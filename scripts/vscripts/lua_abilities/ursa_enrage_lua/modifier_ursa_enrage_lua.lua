modifier_ursa_enrage_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:IsHidden()
	return false
end

function modifier_ursa_enrage_lua:IsDebuff()
	return false
end

function modifier_ursa_enrage_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
		self.stack_multiplier = self:GetAbility():GetSpecialValueFor("enrage_multiplier")
	end
end

function modifier_ursa_enrage_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
		self.stack_multiplier = self:GetAbility():GetSpecialValueFor("enrage_multiplier")
	end
end
--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:DeclareFunctions()
	-- todo: connect stack multiplier with fury swipes
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:GetModifierIncomingDamage_Percentage( params )
	if IsServer() then
		return -self.damage_reduction
	end
end
