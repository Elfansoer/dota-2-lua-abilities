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
razor_storm_surge_lua = class({})
LinkLuaModifier( "modifier_razor_storm_surge_lua", "lua_abilities/razor_storm_surge_lua/modifier_razor_storm_surge_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_razor_storm_surge_lua_debuff", "lua_abilities/razor_storm_surge_lua/modifier_razor_storm_surge_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function razor_storm_surge_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_razor/razor_storm_surge_lua.vpcf", context )
end

function razor_storm_surge_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function razor_storm_surge_lua:GetIntrinsicModifierName()
	return "modifier_razor_storm_surge_lua"
end