modifier_bristleback_viscous_nasal_goo_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_viscous_nasal_goo_lua:IsHidden()
	return false
end

function modifier_bristleback_viscous_nasal_goo_lua:IsDebuff()
	return true
end

function modifier_bristleback_viscous_nasal_goo_lua:IsStunDebuff()
	return false
end

function modifier_bristleback_viscous_nasal_goo_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_viscous_nasal_goo_lua:OnCreated( kv )
	-- references
	self.armor_stack = self:GetAbility():GetSpecialValueFor( "armor_per_stack" )
	self.slow_base = self:GetAbility():GetSpecialValueFor( "base_move_slow" )
	self.slow_stack = self:GetAbility():GetSpecialValueFor( "move_slow_per_stack" )

	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_bristleback_viscous_nasal_goo_lua:OnRefresh( kv )
	-- references
	self.armor_stack = self:GetAbility():GetSpecialValueFor( "armor_per_stack" )
	self.slow_base = self:GetAbility():GetSpecialValueFor( "base_move_slow" )
	self.slow_stack = self:GetAbility():GetSpecialValueFor( "move_slow_per_stack" )
	local max_stack = self:GetAbility():GetSpecialValueFor( "stack_limit" )

	if IsServer() then
		if self:GetStackCount()<max_stack then
			self:IncrementStackCount()
		end
	end
end

function modifier_bristleback_viscous_nasal_goo_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bristleback_viscous_nasal_goo_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_bristleback_viscous_nasal_goo_lua:GetModifierPhysicalArmorBonus()
	return -self.armor_stack * self:GetStackCount()
end
function modifier_bristleback_viscous_nasal_goo_lua:GetModifierMoveSpeedBonus_Percentage()
	return -(self.slow_base + self.slow_stack * self:GetStackCount())
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bristleback_viscous_nasal_goo_lua:GetEffectName()
	return "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo_debuff.vpcf"
end

function modifier_bristleback_viscous_nasal_goo_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end