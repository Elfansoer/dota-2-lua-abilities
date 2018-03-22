chaos_knight_chaos_strike_lua = class({})
LinkLuaModifier( "modifier_chaos_knight_chaos_strike_lua", "lua_abilities/chaos_knight_chaos_strike_lua/modifier_chaos_knight_chaos_strike_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function chaos_knight_chaos_strike_lua:GetIntrinsicModifierName()
	return "modifier_chaos_knight_chaos_strike_lua"
end