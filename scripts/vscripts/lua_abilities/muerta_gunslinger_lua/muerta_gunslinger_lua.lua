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
muerta_gunslinger_lua = class({})
LinkLuaModifier( "modifier_muerta_gunslinger_lua", "lua_abilities/muerta_gunslinger_lua/modifier_muerta_gunslinger_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function muerta_gunslinger_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf", context )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function muerta_gunslinger_lua:GetIntrinsicModifierName()
	return "modifier_muerta_gunslinger_lua"
end