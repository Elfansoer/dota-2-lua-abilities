test_lua = class({})
LinkLuaModifier( "modifier_test", "lua_abilities/test/modifier_test", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function test_lua:GetIntrinsicModifierName()
	return "modifier_test"
end
