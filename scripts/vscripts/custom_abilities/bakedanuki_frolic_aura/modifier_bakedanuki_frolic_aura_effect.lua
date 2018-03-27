modifier_bakedanuki_frolic_aura_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_frolic_aura_effect:IsHidden()
	return false
end

function modifier_bakedanuki_frolic_aura_effect:IsDebuff()
	return false
end

function modifier_bakedanuki_frolic_aura_effect:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_frolic_aura_effect:OnCreated( kv )
	-- references
	self.evasion_self = self:GetAbility():GetSpecialValueFor( "evasion_self" ) -- special value
	self.evasion_ally = self:GetAbility():GetSpecialValueFor( "evasion_ally" ) -- special value
end

function modifier_bakedanuki_frolic_aura_effect:OnRefresh( kv )
	-- references
	self.evasion_self = self:GetAbility():GetSpecialValueFor( "evasion_self" ) -- special value
	self.evasion_ally = self:GetAbility():GetSpecialValueFor( "evasion_ally" ) -- special value	
end

function modifier_bakedanuki_frolic_aura_effect:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bakedanuki_frolic_aura_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}

	return funcs
end

function modifier_bakedanuki_frolic_aura_effect:GetModifierEvasion_Constant()
	if self:GetParent()==self:GetCaster() then
		return self.evasion_self
	else
		return self.evasion_ally
	end
end