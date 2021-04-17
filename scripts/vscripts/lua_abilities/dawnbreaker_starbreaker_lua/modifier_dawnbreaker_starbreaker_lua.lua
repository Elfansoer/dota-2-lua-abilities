-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_dawnbreaker_starbreaker_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_starbreaker_lua:IsHidden()
	return false
end

function modifier_dawnbreaker_starbreaker_lua:IsDebuff()
	return false
end

function modifier_dawnbreaker_starbreaker_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_starbreaker_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.swipe_radius = self:GetAbility():GetSpecialValueFor( "swipe_radius" )
	self.swipe_damage = self:GetAbility():GetSpecialValueFor( "swipe_damage" )
	self.swipe_duration = self:GetAbility():GetSpecialValueFor( "sweep_stun_duration" )

	self.smash_radius = self:GetAbility():GetSpecialValueFor( "smash_radius" )
	self.smash_damage = self:GetAbility():GetSpecialValueFor( "smash_damage" )
	self.smash_duration = self:GetAbility():GetSpecialValueFor( "smash_stun_duration" )
	self.smash_distance = self:GetAbility():GetSpecialValueFor( "smash_distance_from_hero" )

	self.selfstun = self:GetAbility():GetSpecialValueFor( "self_stun_duration" )
	self.attacks = self:GetAbility():GetSpecialValueFor( "total_attacks" )
	self.speed = self:GetAbility():GetSpecialValueFor( "movement_speed" )

	self.tree_radius = 100
	self.arc_height = 90
	self.arc_duration = 0.4

	if not IsServer() then return end

	self.forward = Vector( kv.x, kv.y, 0 )
	self.bonus = 0
	self.ctr = 0
	local interval = self:GetDuration()/(self.attacks-1)

	-- apply forward motion
	self:ApplyHorizontalMotionController()

	-- Start interval
	self:StartIntervalThink( interval )
	self:OnIntervalThink()
end

function modifier_dawnbreaker_starbreaker_lua:OnRefresh( kv )
end

function modifier_dawnbreaker_starbreaker_lua:OnRemoved()
end

function modifier_dawnbreaker_starbreaker_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_starbreaker_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SUPPRESS_CLEAVE,
	}

	return funcs
end

function modifier_dawnbreaker_starbreaker_lua:GetModifierPreAttack_BonusDamage()
	if not IsServer() then return 0 end

	return self.bonus
end

function modifier_dawnbreaker_starbreaker_lua:GetSuppressCleave()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dawnbreaker_starbreaker_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_starbreaker_lua:OnIntervalThink()
	-- if stunned, destroy
	if self.parent:IsStunned() then
		self:Destroy()
		return
	end

	self.ctr = self.ctr + 1
	if self.ctr>=self.attacks then
		self:Smash()
	else
		self:Swipe()
	end
end

function modifier_dawnbreaker_starbreaker_lua:Swipe()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.swipe_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- attack
		self.bonus = self.swipe_damage
		self.parent:PerformAttack( enemy, true, true, true, true, false, false, true )

		-- slow
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier(
				self.parent, -- player source
				self:GetAbility(), -- ability source
				"modifier_dawnbreaker_starbreaker_lua_slow", -- modifier name
				{ duration = self.swipe_duration } -- kv
			)
		end
	end

	-- increment luminosity stack
	if #enemies>0 then
		local mod1 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_lua" )
		local mod2 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_lua_buff" )

		if mod2 then
			mod2:Destroy()
		elseif mod1 then
			mod1:Increment()
		end
	end

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_dawnbreaker_starbreaker_lua:Smash()
	local center = self.parent:GetOrigin() + self.forward*self.smash_distance

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		center,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.smash_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- attack
		self.bonus = self.smash_damage
		self.parent:PerformAttack( enemy, true, true, true, true, false, false, true )

		-- stun
		if not enemy:IsMagicImmune() then
			enemy:AddNewModifier(
				self.parent, -- player source
				self:GetAbility(), -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = self.smash_duration } -- kv
			)

			enemy:AddNewModifier(
				self.parent, -- player source
				self:GetAbility(), -- ability source
				"modifier_generic_arc_lua", -- modifier name
				{
					duration = self.arc_duration,
					height = self.arc_height,
					activity = ACT_DOTA_FLAIL,
				} -- kv
			)
		end
	end

	-- self stun
	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.selfstun } -- kv
	)

	-- increment luminosity stack
	if #enemies>0 then
		local mod1 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_lua" )
		local mod2 = self.parent:FindModifierByName( "modifier_dawnbreaker_luminosity_lua_buff" )

		if mod2 then
			mod2:Destroy()
		elseif mod1 then
			mod1:Increment()
		end
	end

	-- play effects
	self:PlayEffects3( center )
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_dawnbreaker_starbreaker_lua:UpdateHorizontalMotion( me, dt )
	-- get forward pos
	local pos = me:GetOrigin() + self.forward * self.speed * dt

	-- if not traversable, stop
	if not GridNav:IsTraversable( pos ) then return end

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( me:GetOrigin(), self.tree_radius, true )

	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
end

function modifier_dawnbreaker_starbreaker_lua:OnHorizontalMotionInterrupted()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_starbreaker_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep_cast.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_dawnbreaker_starbreaker_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Fire_Wreath.Sweep"

	-- Get Data
	local forward = RotatePosition( Vector(0,0,0), QAngle( 0, -120, 0 ), self.forward )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 0, forward )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dawnbreaker_starbreaker_lua:PlayEffects3( center )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_smash.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Fire_Wreath.Smash"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end