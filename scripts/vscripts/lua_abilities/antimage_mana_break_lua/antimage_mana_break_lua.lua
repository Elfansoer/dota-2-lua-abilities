antimage_mana_break_lua = class({})
LinkLuaModifier( "modifier_antimage_mana_break_lua", "lua_abilities/antimage_mana_break_lua/modifier_antimage_mana_break_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function antimage_mana_break_lua:GetIntrinsicModifierName()
	return "modifier_antimage_mana_break_lua"
end