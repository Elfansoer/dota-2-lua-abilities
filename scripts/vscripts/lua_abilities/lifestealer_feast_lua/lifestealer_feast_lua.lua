lifestealer_feast_lua = class({})
LinkLuaModifier( "modifier_lifestealer_feast_lua", "lua_abilities/lifestealer_feast_lua/modifier_lifestealer_feast_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function lifestealer_feast_lua:GetIntrinsicModifierName()
	return "modifier_lifestealer_feast_lua"
end