modifier_tidehunter_anchor_smash_lua = class({})

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash_lua:OnCreated( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_tidehunter_anchor_smash_lua:OnRefresh( kv )
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end
--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.reduction
end

