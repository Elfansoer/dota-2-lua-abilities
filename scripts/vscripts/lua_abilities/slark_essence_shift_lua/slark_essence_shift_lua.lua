slark_essence_shift_lua = class({})
LinkLuaModifier( "modifier_slark_essence_shift_lua", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_lua_debuff", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_lua_stack", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_essence_shift_lua:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_lua"
end