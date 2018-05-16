sona_crescendo = class({})
LinkLuaModifier( "modifier_sona_crescendo", "custom_abilities/sona_crescendo/modifier_sona_crescendo", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_valor", "custom_abilities/sona_crescendo/modifier_sona_crescendo_valor", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_celerity", "custom_abilities/sona_crescendo/modifier_sona_crescendo_celerity", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_perseverance", "custom_abilities/sona_crescendo/modifier_sona_crescendo_perseverance", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_valor_attack", "custom_abilities/sona_crescendo/modifier_sona_crescendo_valor_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_celerity_attack", "custom_abilities/sona_crescendo/modifier_sona_crescendo_celerity_attack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sona_crescendo_perseverance_attack", "custom_abilities/sona_crescendo/modifier_sona_crescendo_perseverance_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sona_crescendo:GetIntrinsicModifierName()
	return "modifier_sona_crescendo"
end