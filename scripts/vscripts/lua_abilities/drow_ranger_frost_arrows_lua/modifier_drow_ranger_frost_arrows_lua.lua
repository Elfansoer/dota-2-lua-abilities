modifier_drow_ranger_frost_arrows_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_frost_arrows_lua:IsHidden()
	return false
end

function modifier_drow_ranger_frost_arrows_lua:IsDebuff()
	return true
end

function modifier_drow_ranger_frost_arrows_lua:IsStunDebuff()
	return false
end

function modifier_drow_ranger_frost_arrows_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_frost_arrows_lua:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "frost_arrows_movement_speed" )
end

function modifier_drow_ranger_frost_arrows_lua:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "frost_arrows_movement_speed" )
end

function modifier_drow_ranger_frost_arrows_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_frost_arrows_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_drow_ranger_frost_arrows_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_drow_ranger_frost_arrows_lua:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_drow_ranger_frost_arrows_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end