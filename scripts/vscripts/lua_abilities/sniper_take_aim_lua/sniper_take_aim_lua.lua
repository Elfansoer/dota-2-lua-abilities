sniper_take_aim_lua = class({})
LinkLuaModifier( "modifier_sniper_take_aim_lua", "lua_abilities/sniper_take_aim_lua/modifier_sniper_take_aim_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sniper_take_aim_lua:GetIntrinsicModifierName()
	return "modifier_sniper_take_aim_lua"
end