sand_king_caustic_finale_lua = class({})
LinkLuaModifier( "modifier_sand_king_caustic_finale_lua", "lua_abilities/sand_king_caustic_finale_lua/modifier_sand_king_caustic_finale_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sand_king_caustic_finale_lua_debuff", "lua_abilities/sand_king_caustic_finale_lua/modifier_sand_king_caustic_finale_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sand_king_caustic_finale_lua_slow", "lua_abilities/sand_king_caustic_finale_lua/modifier_sand_king_caustic_finale_lua_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sand_king_caustic_finale_lua:GetIntrinsicModifierName()
	return "modifier_sand_king_caustic_finale_lua"
end