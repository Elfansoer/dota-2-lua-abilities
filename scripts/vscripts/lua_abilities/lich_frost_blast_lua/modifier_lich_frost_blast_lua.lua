modifier_lich_frost_blast_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_frost_blast_lua:IsHidden()
	return false
end

function modifier_lich_frost_blast_lua:IsDebuff()
	return true
end

function modifier_lich_frost_blast_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_frost_blast_lua:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_lich_frost_blast_lua:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_lich_frost_blast_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_frost_blast_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_lich_frost_blast_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end
function modifier_lich_frost_blast_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_lich_frost_blast_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_lich/lich_slowed_cold.vpcf"
-- end

-- function modifier_lich_frost_blast_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_lich_frost_blast_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end