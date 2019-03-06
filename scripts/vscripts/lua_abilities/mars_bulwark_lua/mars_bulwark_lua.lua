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
mars_bulwark_lua = class({})
LinkLuaModifier( "modifier_mars_bulwark_lua", "lua_abilities/mars_bulwark_lua/modifier_mars_bulwark_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function mars_bulwark_lua:GetIntrinsicModifierName()
	return "modifier_mars_bulwark_lua"
end