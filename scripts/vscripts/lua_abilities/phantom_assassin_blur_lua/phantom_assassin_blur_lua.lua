phantom_assassin_blur_lua = class({})
LinkLuaModifier( "modifier_phantom_assassin_blur_lua", "lua_abilities/phantom_assassin_blur_lua/modifier_phantom_assassin_blur_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function phantom_assassin_blur_lua:GetIntrinsicModifierName()
	return "modifier_phantom_assassin_blur_lua"
end
