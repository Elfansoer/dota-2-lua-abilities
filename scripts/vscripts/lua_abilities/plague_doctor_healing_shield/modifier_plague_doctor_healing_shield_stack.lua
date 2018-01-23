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
	if IsServer() then
		-- get references
		self.amplify = self:GetAbility():GetSpecialValueFor("stack_amplification_pct")
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
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield_stack:GetModifierHealAmplify_Percentage( params )
	return self.amplify
end

