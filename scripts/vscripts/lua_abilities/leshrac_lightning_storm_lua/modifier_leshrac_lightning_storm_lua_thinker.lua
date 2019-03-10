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
modifier_leshrac_lightning_storm_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_leshrac_lightning_storm_lua_thinker:IsHidden()
	return true
end

function modifier_leshrac_lightning_storm_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_leshrac_lightning_storm_lua_thinker:OnCreated( kv )
	if not IsServer() then return end

	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "jump_delay" )
	self.count = self:GetAbility():GetSpecialValueFor( "jump_count" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" )

	-- init and precache
	self.targets = {}
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self:GetAbility():GetAbilityDamage(),
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)
end

function modifier_leshrac_lightning_storm_lua_thinker:Cast( target )
	-- guaranteed on server
	self.current_target = target
	self.started = false
	self:StartIntervalThink( self.delay )
end

function modifier_leshrac_lightning_storm_lua_thinker:OnRefresh( kv )
	
end

function modifier_leshrac_lightning_storm_lua_thinker:OnRemoved()
end

function modifier_leshrac_lightning_storm_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_leshrac_lightning_storm_lua_thinker:OnIntervalThink()
	if not self.started then
		self.started = true

		self:Struck( self.current_target )
		return
	end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self.current_target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local found = false
	for _,enemy in pairs(enemies) do
		if not self.targets[enemy] then
			found = true
			self.current_target = enemy
			self:Struck( enemy )
			break
		end
	end

	if not found then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_leshrac_lightning_storm_lua_thinker:Struck( target )
	if not target:IsMagicImmune() then
		-- damage
		self.damageTable.victim = target
		ApplyDamage( self.damageTable )

		-- slow
		target:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_leshrac_lightning_storm_lua", -- modifier name
			{
				duration = self.duration,
				slow = self.slow,
			} -- kv
		)

		-- track targeted
		self.targets[target] = true

	end

	-- play effects
	self:PlayEffects( target )

	-- count
	self.count = self.count - 1
	if self.count<=0 then
		self:Destroy()
	end
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_leshrac_lightning_storm_lua_thinker:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf"
	local sound_cast = "Hero_Leshrac.Lightning_Storm"

	-- get data
	local location = target:GetOrigin()
	local height = Vector( 0, 0, 100 )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, target )
	ParticleManager:SetParticleControl( effect_cast, 0, location + Vector( 0, 0, 800 ) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end