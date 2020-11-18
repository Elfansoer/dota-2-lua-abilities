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
dark_seer_vacuum_lua = class({})
LinkLuaModifier( "modifier_dark_seer_vacuum_lua", "lua_abilities/dark_seer_vacuum_lua/modifier_dark_seer_vacuum_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Init Abilities
function dark_seer_vacuum_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function dark_seer_vacuum_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function dark_seer_vacuum_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "scepter_cooldown" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_seer_vacuum_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor( "radius" )
	local tree = self:GetSpecialValueFor( "radius_tree" )
	local duration = self:GetSpecialValueFor( "duration" )

	-- find units
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_dark_seer_vacuum_lua", -- modifier name
			{
				duration = duration,
				x = point.x,
				y = point.y,
			} -- kv
		)
	end

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( point, tree, false )

	-- play effects
	self:PlayEffects( point, radius )
end

--------------------------------------------------------------------------------
function dark_seer_vacuum_lua:PlayEffects( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_vacuum.vpcf"
	local sound_cast = "Hero_Dark_Seer.Vacuum"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end