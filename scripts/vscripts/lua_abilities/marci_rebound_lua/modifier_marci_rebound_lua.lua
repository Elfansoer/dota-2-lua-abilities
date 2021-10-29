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
modifier_marci_rebound_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_rebound_lua:IsHidden()
	return true
end

function modifier_marci_rebound_lua:IsDebuff()
	return false
end

function modifier_marci_rebound_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_rebound_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	-- self.duration = self:GetAbility():GetSpecialValueFor( "max_lob_travel_time" )
	self.duration = 0.5
	self.height = self:GetAbility():GetSpecialValueFor( "min_height_above_highest" )
	self.min_distance = self:GetAbility():GetSpecialValueFor( "min_jump_distance" )
	self.max_distance = self:GetAbility():GetSpecialValueFor( "max_jump_distance" )

	self.radius = self:GetAbility():GetSpecialValueFor( "landing_radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "impact_damage" )
	self.debuff = self:GetAbility():GetSpecialValueFor( "debuff_duration" )
	self.buff = self:GetAbility():GetSpecialValueFor( "ally_buff_duration" )

	if not IsServer() then return end
	self.projectile = tonumber(kv.proj)
	self.target = EntIndexToHScript( kv.target )
	self.point = Vector( kv.point_x, kv.point_y, 0 )

	-- precaution against non-dodging TPs
	self.targetpos = self.target:GetOrigin()
	self.distancethreshold = 1000

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end

	-- play effects
	local speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self:PlayEffects1( self.parent, speed )
end

function modifier_marci_rebound_lua:OnRefresh( kv )
	
end

function modifier_marci_rebound_lua:OnRemoved()
end

function modifier_marci_rebound_lua:OnDestroy()
	if not IsServer() then return end	
	self:GetParent():RemoveHorizontalMotionController( self )

	if self.interrupted then return end

	-- add buff to ally
	local allied = self.target:GetTeamNumber()==self.parent:GetTeamNumber()
	if allied then
		self.target:AddNewModifier(
			self.parent, -- player source
			self.ability, -- ability source
			"modifier_marci_rebound_lua_buff", -- modifier name
			{ duration = self.buff } -- kv
		)
	end

	local origin =  self:GetParent():GetOrigin()
	local direction = self.point - origin
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()

	-- face towards
	self:GetParent():SetForwardVector( direction )

	local duration = 0.5
	local distance = math.min(math.max(distance,self.min_distance),self.max_distance)

	-- create arc
	local arc = self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{ 
			dir_x = direction.x,
			dir_y = direction.y,
			duration = self.duration,
			distance = distance,
			height = self.height,
			fix_end = false,
			isStun = true,
			isForward = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	arc:SetEndCallback( function( interrupted )
		-- find enemies
		local enemies = FindUnitsInRadius(
			self.parent:GetTeamNumber(),	-- int, your team number
			self.parent:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- precache damage
		local damageTable = {
			-- victim = target,
			attacker = self.parent,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability, --Optional.
		}

		for _,enemy in pairs(enemies) do

			-- damage
			damageTable.victim = enemy
			ApplyDamage(damageTable)

			-- slow
			enemy:AddNewModifier(
				self.parent, -- player source
				self.ability, -- ability source
				"modifier_marci_rebound_lua_debuff", -- modifier name
				{ duration = self.debuff } -- kv
			)
		end

		-- play effects
		self:PlayEffects4( self.parent:GetOrigin(), origin, self.radius )
	end)

	-- play effects
	self:PlayEffects2( self.parent, arc, allied )
	self:PlayEffects3( origin + distance*direction, self.radius )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_rebound_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_marci_rebound_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_marci_rebound_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_marci_rebound_lua:UpdateHorizontalMotion( me, dt )
	-- precaution against non-dodging tps
	local targetpos = self.target:GetOrigin()
	if (targetpos - self.targetpos):Length2D()>self.distancethreshold then
		self.dodged = true
		self.interrupted = true
		return
	end
	self.targetpos = targetpos

	local loc = ProjectileManager:GetTrackingProjectileLocation( self.projectile )
	me:SetOrigin( GetGroundPosition( loc, me ) )

	-- face towards
	me:FaceTowards( self.target:GetOrigin() )
end

function modifier_marci_rebound_lua:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations

function modifier_marci_rebound_lua:PlayEffects1( caster, speed )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_rebound_charge_projectile.vpcf"
	local sound_cast = "Hero_Marci.Rebound.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( speed, 0, 0 ) )

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
	EmitSoundOn( sound_cast, caster )
end

function modifier_marci_rebound_lua:PlayEffects2( caster, buff )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf"
	local sound_cast = "Hero_Marci.Rebound.Leap"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	buff:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end


function modifier_marci_rebound_lua:PlayEffects3( center, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_rebound_landing_zone.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_marci_rebound_lua:PlayEffects4( center, origin, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf"
	local sound_cast = "Hero_Marci.Rebound.Impact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	ParticleManager:SetParticleControl( effect_cast, 1, origin )
	ParticleManager:SetParticleControl( effect_cast, 9, Vector(radius, radius, radius) )
	ParticleManager:SetParticleControl( effect_cast, 10, center )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( center, sound_cast, self.parent )
end