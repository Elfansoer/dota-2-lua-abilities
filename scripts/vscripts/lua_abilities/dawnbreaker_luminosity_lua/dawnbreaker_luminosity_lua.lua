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
dawnbreaker_luminosity_lua = class({})
LinkLuaModifier( "modifier_dawnbreaker_luminosity_lua", "lua_abilities/dawnbreaker_luminosity_lua/modifier_dawnbreaker_luminosity_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dawnbreaker_luminosity_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dawnbreaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity_attack_buff.vpcf", context )
end

function dawnbreaker_luminosity_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function dawnbreaker_luminosity_lua:GetIntrinsicModifierName()
	return "modifier_dawnbreaker_luminosity_lua"
end