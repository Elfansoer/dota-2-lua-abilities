modifier_axe_culling_blade_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_culling_blade_lua:IsHidden()
	return false
end

function modifier_axe_culling_blade_lua:IsDebuff()
	return false
end

function modifier_axe_culling_blade_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_culling_blade_lua:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus_tooltip" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" ) -- special value
end

function modifier_axe_culling_blade_lua:OnRefresh( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "atk_speed_bonus_tooltip" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" ) -- special value
end

function modifier_axe_culling_blade_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_axe_culling_blade_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end
function modifier_axe_culling_blade_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end
function modifier_axe_culling_blade_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_culling_blade_lua:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_cullingblade_sprint.vpcf"
end

function modifier_axe_culling_blade_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end