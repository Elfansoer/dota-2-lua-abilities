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
dragon_knight_dragon_blood_lua = class({})
LinkLuaModifier( "modifier_dragon_knight_dragon_blood_lua", "lua_abilities/dragon_knight_dragon_blood_lua/modifier_dragon_knight_dragon_blood_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function dragon_knight_dragon_blood_lua:GetIntrinsicModifierName()
	return "modifier_dragon_knight_dragon_blood_lua"
end