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
lina_fiery_soul_lua = class({})
LinkLuaModifier( "modifier_lina_fiery_soul_lua", "lua_abilities/lina_fiery_soul_lua/modifier_lina_fiery_soul_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function lina_fiery_soul_lua:GetIntrinsicModifierName()
	return "modifier_lina_fiery_soul_lua"
end