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
storm_spirit_electric_vortex_lua = class({})
LinkLuaModifier( "modifier_storm_spirit_electric_vortex_lua", "lua_abilities/storm_spirit_electric_vortex_lua/modifier_storm_spirit_electric_vortex_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Init Abilities
function storm_spirit_electric_vortex_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
function storm_spirit_electric_vortex_lua:GetBehavior()
	if self:GetCaster():HasScepter() then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET
	end
	
	return self.BaseClass.GetBehavior( self )
end

-- AOE Radius
function storm_spirit_electric_vortex_lua:GetCastRange( location, target )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "radius_scepter" )
	end

	return self.BaseClass.GetCastRange( self, location, target )
end

--------------------------------------------------------------------------------
-- Ability Start
function storm_spirit_electric_vortex_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetDuration()
	local radius = self:GetSpecialValueFor( "radius_scepter" )

	-- find targets
	local targets = {}
	if caster:HasScepter() then
		targets = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			self:GetAbilityTargetTeam(),	-- int, team filter
			self:GetAbilityTargetType(),	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
	else
		table.insert( targets, target )
	end

	for _,enemy in pairs(targets) do
		-- apply modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_storm_spirit_electric_vortex_lua", -- modifier name
			{
				duration = duration,
				x = caster:GetOrigin().x,
				y = caster:GetOrigin().y,
			} -- kv
		)
	end

	-- play effects
	local sound_cast = "Hero_StormSpirit.ElectricVortexCast"
	EmitSoundOn( sound_cast, caster )
end