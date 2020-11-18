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
storm_spirit_static_remnant_lua = class({})
LinkLuaModifier( "modifier_storm_spirit_static_remnant_lua_thinker", "lua_abilities/storm_spirit_static_remnant_lua/modifier_storm_spirit_static_remnant_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function storm_spirit_static_remnant_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function storm_spirit_static_remnant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetDuration()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_storm_spirit_static_remnant_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
end