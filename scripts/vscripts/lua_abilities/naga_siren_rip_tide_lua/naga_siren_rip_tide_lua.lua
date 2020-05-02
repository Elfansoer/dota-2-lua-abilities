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
naga_siren_rip_tide_lua = class({})
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua", "lua_abilities/naga_siren_rip_tide_lua/modifier_naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua_debuff", "lua_abilities/naga_siren_rip_tide_lua/modifier_naga_siren_rip_tide_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function naga_siren_rip_tide_lua:GetIntrinsicModifierName()
	return "modifier_naga_siren_rip_tide_lua"
end