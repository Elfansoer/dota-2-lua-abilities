modifier_invoker_wex_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_wex_lua:IsHidden()
	return false
end

function modifier_invoker_wex_lua:IsDebuff()
	return false
end

function modifier_invoker_wex_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_wex_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_wex_lua:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_per_instance" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "move_speed_per_instance" ) -- special value
end

function modifier_invoker_wex_lua:OnRefresh( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_per_instance" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "move_speed_per_instance" ) -- special value
end

function modifier_invoker_wex_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_wex_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_invoker_wex_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end
function modifier_invoker_wex_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end
