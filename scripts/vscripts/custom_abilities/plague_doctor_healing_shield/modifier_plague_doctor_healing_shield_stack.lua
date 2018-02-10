modifier_plague_doctor_healing_shield_stack = class({})

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield_stack:IsHidden()
	return true
end

function modifier_plague_doctor_healing_shield_stack:IsDebuff()
	return false
end

function modifier_plague_doctor_healing_shield_stack:IsPurgable()
	return false
end

function modifier_plague_doctor_healing_shield_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield_stack:OnCreated( kv )
	-- get references
	self.amplify = self:GetAbility():GetSpecialValueFor("stack_amplification_pct")
	if IsServer() then
		self.modifier = self:GetAbility():RetATValue( kv.modifier )
	end
end

function modifier_plague_doctor_healing_shield_stack:OnDestroy( kv )
	if IsServer() then
		self.modifier:MinStack()
	end
end
--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield_stack:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE, --(not working)
		-- MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE, --(get max health as regen instead)
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------

-- function modifier_plague_doctor_healing_shield_stack:GetModifierHealAmplify_Percentage( params )
-- 	return self.amplify
-- end

-- function modifier_plague_doctor_healing_shield_stack:GetModifierHealthRegenPercentage()
-- 	return self.amplify
-- end

function modifier_plague_doctor_healing_shield_stack:GetModifierConstantHealthRegen( params )
	return self.amplify
end
