modifier_crystal_maiden_crystal_nova_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_crystal_maiden_crystal_nova_lua:IsHidden()
	return false
end

function modifier_crystal_maiden_crystal_nova_lua:IsDebuff()
	return true
end

function modifier_crystal_maiden_crystal_nova_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_crystal_maiden_crystal_nova_lua:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" ) -- special value
end

function modifier_crystal_maiden_crystal_nova_lua:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "attackspeed_slow" ) -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "movespeed_slow" ) -- special value	
end

function modifier_crystal_maiden_crystal_nova_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_crystal_maiden_crystal_nova_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_crystal_maiden_crystal_nova_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_crystal_nova_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_crystal_maiden_crystal_nova_lua:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_crystal_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end