modifier_wraith_king_reincarnation_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_reincarnation_lua_debuff:IsHidden()
	return false
end

function modifier_wraith_king_reincarnation_lua_debuff:IsDebuff()
	return true
end

function modifier_wraith_king_reincarnation_lua_debuff:IsStunDebuff()
	return false
end

function modifier_wraith_king_reincarnation_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_reincarnation_lua_debuff:OnCreated( kv )
	-- references
	self.move_slow = self:GetAbility():GetSpecialValueFor( "movespeed" ) -- special value
	self.attack_slow = self:GetAbility():GetSpecialValueFor( "attackslow_tooltip" ) -- special value
end

function modifier_wraith_king_reincarnation_lua_debuff:OnRefresh( kv )
	-- references
	self.move_slow = self:GetAbility():GetSpecialValueFor( "movespeed" ) -- special value
	self.attack_slow = self:GetAbility():GetSpecialValueFor( "attackslow_tooltip" ) -- special value
end

function modifier_wraith_king_reincarnation_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_reincarnation_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_wraith_king_reincarnation_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.attack_slow
end

function modifier_wraith_king_reincarnation_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_reincarnation_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate_slow_debuff.vpcf"
end

function modifier_wraith_king_reincarnation_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end