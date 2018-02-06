modifier_ursa_overpower_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
		self.max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")

		-- Increase stack
		self:SetStackCount(self.max_attacks)
	end
end

function modifier_ursa_overpower_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.bonus = self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
		self.max_attacks = self:GetAbility():GetSpecialValueFor("max_attacks")

		-- Increase stack
		self:SetStackCount(self.max_attacks)
	end
end
--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_overpower_lua:GetModifierAttackSpeedBonus_Constant()
	return self.bonus
end

function modifier_ursa_overpower_lua:OnAttackLanded( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.attacker==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			-- decrement stack
			self:DecrementStackCount()

			-- destroy if reach zero
			if self:GetStackCount() < 1 then
				self:Destroy()
			end
		end
	end
end
