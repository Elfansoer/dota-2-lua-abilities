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
storm_spirit_overload_lua = class({})
LinkLuaModifier( "modifier_storm_spirit_overload_lua", "lua_abilities/storm_spirit_overload_lua/modifier_storm_spirit_overload_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_storm_spirit_overload_lua_buff", "lua_abilities/storm_spirit_overload_lua/modifier_storm_spirit_overload_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_storm_spirit_overload_lua_debuff", "lua_abilities/storm_spirit_overload_lua/modifier_storm_spirit_overload_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function storm_spirit_overload_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_stormspirit/stormspirit_overload_ambient.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf", context )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function storm_spirit_overload_lua:GetIntrinsicModifierName()
	return "modifier_storm_spirit_overload_lua"
end