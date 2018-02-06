ursa_fury_swipes_lua = class({})
LinkLuaModifier( "modifier_ursa_fury_swipes_lua", "lua_abilities/ursa_fury_swipes_lua/modifier_ursa_fury_swipes_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ursa_fury_swipes_debuff_lua", "lua_abilities/ursa_fury_swipes_lua/modifier_ursa_fury_swipes_debuff_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function ursa_fury_swipes_lua:GetIntrinsicModifierName()
	return "modifier_ursa_fury_swipes_lua"
end
