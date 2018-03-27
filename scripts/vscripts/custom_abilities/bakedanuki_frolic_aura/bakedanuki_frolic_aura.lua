bakedanuki_frolic_aura = class({})
LinkLuaModifier( "modifier_bakedanuki_frolic_aura", "custom_abilities/bakedanuki_frolic_aura/modifier_bakedanuki_frolic_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bakedanuki_frolic_aura_effect", "custom_abilities/bakedanuki_frolic_aura/modifier_bakedanuki_frolic_aura_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function bakedanuki_frolic_aura:GetIntrinsicModifierName()
	return "modifier_bakedanuki_frolic_aura"
end