modifier_tidehunter_anchor_smash = class({})

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash:OnCreated( kv )
	if IsServer() then
		self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	end
end

function modifier_tidehunter_anchor_smash:OnRefresh( kv )
	if IsServer() then
		self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	end
end
--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_tidehunter_anchor_smash:GetModifierBaseDamageOutgoing_Percentage()
	return self.reduction
end

