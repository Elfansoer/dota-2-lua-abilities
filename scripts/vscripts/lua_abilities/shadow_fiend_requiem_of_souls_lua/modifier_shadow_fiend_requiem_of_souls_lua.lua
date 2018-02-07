modifier_shadow_fiend_requiem_of_souls_lua = class({})

--------------------------------------------------------------------------------

function modifier_shadow_fiend_requiem_of_souls_lua:IsDebuff()
	return true
end

function modifier_shadow_fiend_requiem_of_souls_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_requiem_of_souls_lua:OnCreated( kv )
	self.reduction_ms_pct = self:GetAbility():GetSpecialValueFor("requiem_reduction_ms")
	self.reduction_damage_pct = self:GetAbility():GetSpecialValueFor("requiem_reduction_damage")
end

function modifier_shadow_fiend_requiem_of_souls_lua:OnRefresh( kv )
	self.reduction_ms_pct = self:GetAbility():GetSpecialValueFor("requiem_reduction_ms")
	self.reduction_damage_pct = self:GetAbility():GetSpecialValueFor("requiem_reduction_damage")
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_requiem_of_souls_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_shadow_fiend_requiem_of_souls_lua:GetModifierDamageOutgoing_Percentage()
	return self.reduction_damage_pct
end

function modifier_shadow_fiend_requiem_of_souls_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.reduction_ms_pct
end