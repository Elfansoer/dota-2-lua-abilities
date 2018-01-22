modifier_troll_warlord_fervor = class({})

function modifier_troll_warlord_fervor:OnCreated( kv )
	if IsServer() then
		self:SetStackCount(1)
		self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
		self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
		self.currentTarget = {}
	end
end

function modifier_troll_warlord_fervor:OnRefresh( kv )
	if IsServer() then
		self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
		self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
	end
end

--------------------------------------------------------------------------------

function modifier_troll_warlord_fervor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK_START
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_troll_warlord_fervor:OnAttackStart( params )
	if IsServer() then
		-- filter
		pass = false
		if params.attacker==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			-- check if it is the same target
			if self.currentTarget==params.target then
				self:AddStack()
			else
				self:ResetStack()
			end
		end
	end
end

function modifier_troll_warlord_fervor:GetModifierAttackSpeedBonus_Constant( params )
	if IsServer() then
		return self:GetStackCount() * self.stack_multiplier
	end
end

function modifier_troll_warlord_fervor:AddStack()
	-- check if it is not maximum
	if self:GetStackCount < self.max_stacks then
		self:IncrementStackCount()
	end
end

function modifier_troll_warlord_fervor:ResetStack()
	self:SetStackCount(1)
end
