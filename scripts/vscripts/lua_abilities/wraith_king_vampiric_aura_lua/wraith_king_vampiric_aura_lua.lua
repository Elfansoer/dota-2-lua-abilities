wraith_king_vampiric_aura_lua = class({})
LinkLuaModifier( "modifier_wraith_king_vampiric_aura_lua", "lua_abilities/wraith_king_vampiric_aura_lua/modifier_wraith_king_vampiric_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_wraith_king_vampiric_aura_lua_lifesteal", "lua_abilities/wraith_king_vampiric_aura_lua/modifier_wraith_king_vampiric_aura_lua_lifesteal", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function wraith_king_vampiric_aura_lua:GetIntrinsicModifierName()
	return "modifier_wraith_king_vampiric_aura_lua"
end