modifier_centaur_warrunner_stampede_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_centaur_warrunner_stampede_lua_debuff:IsHidden()
	return false
end

function modifier_centaur_warrunner_stampede_lua_debuff:IsDebuff()
	return true
end

function modifier_centaur_warrunner_stampede_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_centaur_warrunner_stampede_lua_debuff:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_centaur_warrunner_stampede_lua_debuff:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_centaur_warrunner_stampede_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_centaur_warrunner_stampede_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_centaur_warrunner_stampede_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_centaur_warrunner_stampede_lua_debuff:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_centaur_warrunner_stampede_lua_debuff:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end