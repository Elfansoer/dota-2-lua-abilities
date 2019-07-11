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
timbersaw_reactive_armor_lua = class({})
LinkLuaModifier( "modifier_timbersaw_reactive_armor_lua", "lua_abilities/timbersaw_reactive_armor_lua/modifier_timbersaw_reactive_armor_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_timbersaw_reactive_armor_lua_stack", "lua_abilities/timbersaw_reactive_armor_lua/modifier_timbersaw_reactive_armor_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function timbersaw_reactive_armor_lua:GetIntrinsicModifierName()
	return "modifier_timbersaw_reactive_armor_lua"
end