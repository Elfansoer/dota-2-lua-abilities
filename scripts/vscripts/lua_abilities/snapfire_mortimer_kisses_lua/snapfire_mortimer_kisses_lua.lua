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
snapfire_mortimer_kisses_lua = class({})
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_lua", "lua_abilities/snapfire_mortimer_kisses_lua/modifier_snapfire_mortimer_kisses_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_lua_thinker", "lua_abilities/snapfire_mortimer_kisses_lua/modifier_snapfire_mortimer_kisses_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_snapfire_mortimer_kisses_lua_debuff", "lua_abilities/snapfire_mortimer_kisses_lua/modifier_snapfire_mortimer_kisses_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function snapfire_mortimer_kisses_lua:GetAOERadius()
	return self:GetSpecialValueFor( "impact_radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function snapfire_mortimer_kisses_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_snapfire_mortimer_kisses_lua", -- modifier name
		{
			duration = duration,
			pos_x = point.x,
			pos_y = point.y,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Projectile
function snapfire_mortimer_kisses_lua:OnProjectileHit( target, location )
	if not target then return end

	-- load data
	local damage = self:GetSpecialValueFor( "damage_per_impact" )
	local duration = self:GetSpecialValueFor( "burn_ground_duration" )
	local impact_radius = self:GetSpecialValueFor( "impact_radius" )
	local vision = self:GetSpecialValueFor( "projectile_vision" )

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		location,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		impact_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	-- start aura on thinker
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_snapfire_mortimer_kisses_lua_thinker", -- modifier name
		{
			duration = duration,
			slow = 1,
		} -- kv
	)

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( location, impact_radius, true )

	-- create Vision
	AddFOWViewer( self:GetCaster():GetTeamNumber(), location, vision, duration, false )

	-- play effects
	self:PlayEffects( target:GetOrigin() )
end

--------------------------------------------------------------------------------
function snapfire_mortimer_kisses_lua:PlayEffects( loc )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_impact.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_linger.vpcf"
	local sound_cast = "Hero_Snapfire.MortimerBlob.Impact"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 3, loc )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	local effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, loc )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	local sound_location = "Hero_Snapfire.MortimerBlob.Impact"
	EmitSoundOnLocationWithCaster( loc, sound_location, self:GetCaster() )
end