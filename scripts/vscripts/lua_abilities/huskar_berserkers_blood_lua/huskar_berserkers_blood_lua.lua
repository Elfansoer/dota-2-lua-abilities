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
huskar_berserkers_blood_lua = class({})
LinkLuaModifier( "modifier_huskar_berserkers_blood_lua", "lua_abilities/huskar_berserkers_blood_lua/modifier_huskar_berserkers_blood_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function huskar_berserkers_blood_lua:GetIntrinsicModifierName()
	return "modifier_huskar_berserkers_blood_lua"
end