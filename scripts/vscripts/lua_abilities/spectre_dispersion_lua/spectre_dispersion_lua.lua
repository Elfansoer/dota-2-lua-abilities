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
spectre_dispersion_lua = class({})
LinkLuaModifier( "modifier_spectre_dispersion_lua", "lua_abilities/spectre_dispersion_lua/modifier_spectre_dispersion_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function spectre_dispersion_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_dispersion.vpcf", context )
end

function spectre_dispersion_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function spectre_dispersion_lua:GetIntrinsicModifierName()
	return "modifier_spectre_dispersion_lua"
end