riven_runic_blade = class({})
LinkLuaModifier( "modifier_riven_runic_blade", "custom_abilities/riven_runic_blade/modifier_riven_runic_blade", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_riven_runic_blade_stack", "custom_abilities/riven_runic_blade/modifier_riven_runic_blade_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function riven_runic_blade:GetIntrinsicModifierName()
	return "modifier_riven_runic_blade"
end