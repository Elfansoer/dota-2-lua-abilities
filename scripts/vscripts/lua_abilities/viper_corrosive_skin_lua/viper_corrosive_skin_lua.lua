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
viper_corrosive_skin_lua = class({})
LinkLuaModifier( "modifier_viper_corrosive_skin_lua", "lua_abilities/viper_corrosive_skin_lua/modifier_viper_corrosive_skin_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_viper_corrosive_skin_lua_debuff", "lua_abilities/viper_corrosive_skin_lua/modifier_viper_corrosive_skin_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function viper_corrosive_skin_lua:GetIntrinsicModifierName()
	return "modifier_viper_corrosive_skin_lua"
end