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
modifier_dawnbreaker_solar_guardian_lua_leap = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_solar_guardian_lua_leap:IsHidden()
	return false
end

function modifier_dawnbreaker_solar_guardian_lua_leap:IsDebuff()
	return false
end

function modifier_dawnbreaker_solar_guardian_lua_leap:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_solar_guardian_lua_leap:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "land_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "land_stun_duration" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- get data
	local arc_height = 2000
	self.point = Vector( kv.x, kv.y, 0 )
	self.interrupted = false

	-- add arc
	local arc = self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			duration = kv.duration,
			height = arc_height,
			isStun = false,
			isForward = true,
		} -- kv
	)
	arc:SetEndCallback(function( interrupted )
		if interrupted then
			self.interrupted = interrupted
			self:Destroy()
		end
	end)

	self:StartIntervalThink( kv.duration/2 )

	-- play effects
	self:PlayEffects1()
end

function modifier_dawnbreaker_solar_guardian_lua_leap:OnRefresh( kv )
end

function modifier_dawnbreaker_solar_guardian_lua_leap:OnRemoved()
end

function modifier_dawnbreaker_solar_guardian_lua_leap:OnDestroy()
	if not IsServer() then return end
	if self.interrupted then return end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.point,	-- point, center point
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
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
	}
	-- ApplyDamage(damageTable)

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- stun
		enemy:AddNewModifier(
			self.parent, -- player source
			self.ability, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = self.duration } -- kv
		)
	end

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( self.point, self.radius/2, false )

	-- play effects
	self:PlayEffects2( self.point, self.radius )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_solar_guardian_lua_leap:OnIntervalThink()
	-- move position to target
	self.point.z = self.parent:GetOrigin().z
	self.parent:SetOrigin( self.point )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_dawnbreaker_solar_guardian_lua_leap:GetEffectName()
-- 	return "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_airtime_buff.vpcf"
-- end

-- function modifier_dawnbreaker_solar_guardian_lua_leap:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_dawnbreaker_solar_guardian_lua_leap:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_airtime_buff.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Solar_Guardian.BlastOff"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )

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

function modifier_dawnbreaker_solar_guardian_lua_leap:PlayEffects2( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_landing.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Solar_Guardian.Impact"

	-- Get Data
	point = GetGroundPosition( point, self.parent )

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self.parent )
end