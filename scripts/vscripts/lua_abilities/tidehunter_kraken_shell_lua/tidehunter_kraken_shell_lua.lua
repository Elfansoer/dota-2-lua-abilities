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
tidehunter_kraken_shell_lua = class({})
LinkLuaModifier( "modifier_tidehunter_kraken_shell_lua", "lua_abilities/tidehunter_kraken_shell_lua/modifier_tidehunter_kraken_shell_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function tidehunter_kraken_shell_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", context )
end

function tidehunter_kraken_shell_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function tidehunter_kraken_shell_lua:GetIntrinsicModifierName()
	return "modifier_tidehunter_kraken_shell_lua"
end