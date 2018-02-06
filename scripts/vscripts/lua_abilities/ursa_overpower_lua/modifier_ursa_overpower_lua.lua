modifier_ursa_overpower_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:OnCreated( kv )
	-- get reference
	self.bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	self.max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")

	-- Increase stack
	self:SetStackCount(self.max_attacks)
end

function modifier_ursa_overpower_lua:OnRefresh( kv )
	-- get reference
	self.bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
	self.max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")

	-- Increase stack
	self:SetStackCount(self.max_attacks)
end
--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus
end

function modifier_ursa_overpower_lua:GetModifierProcAttack_Feedback( params )
	-- decrement stack
	self:DecrementStackCount()

	-- destroy if reach zero
	if self:GetStackCount() < 1 then
		self:Destroy()
	end
end