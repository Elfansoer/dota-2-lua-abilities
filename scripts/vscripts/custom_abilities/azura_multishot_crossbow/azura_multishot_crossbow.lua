azura_multishot_crossbow = class({})
LinkLuaModifier( "modifier_azura_multishot_crossbow", "custom_abilities/azura_multishot_crossbow/modifier_azura_multishot_crossbow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function azura_multishot_crossbow:GetIntrinsicModifierName()
	return "modifier_azura_multishot_crossbow"
end

--------------------------------------------------------------------------------
-- Helper functions
function azura_multishot_crossbow:OnHeroCalculateStatBonus()
	local charge_restore = self:GetSpecialValueFor("charge_restore")
	-- todo: find attack speed value
	local attack_speed = 100
	self.recharge_time = charge_restore * (100/attack_speed)
end