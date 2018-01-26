modifier_troll_warlord_fervor_lua = class({})

--------------------------------------------------------------------------------
-- Initializations

function modifier_troll_warlord_fervor_lua:IsHidden( kv )
	return false
end

function modifier_troll_warlord_fervor_lua:IsDebuff( kv )
	return false
end

function modifier_troll_warlord_fervor_lua:IsPurgable( kv )
	return false
end

function modifier_troll_warlord_fervor_lua:RemoveOnDeath( kv )
	return false
end

--------------------------------------------------------------------------------
-- Life cycle

function modifier_troll_warlord_fervor_lua:OnCreated( kv )
	self:SetStackCount(1)
	self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
	self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
	self.currentTarget = {}
end

function modifier_troll_warlord_fervor_lua:OnRefresh( kv )
	self.stack_multiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
	self.max_stacks = self:GetAbility():GetSpecialValueFor("max_stacks")
end

--------------------------------------------------------------------------------
-- Declare functions

function modifier_troll_warlord_fervor_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ATTACK
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Declared functions

function modifier_troll_warlord_fervor_lua:OnAttack( params )
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
				self.currentTarget = params.target
			end
		end
	end
end

function modifier_troll_warlord_fervor_lua:GetModifierAttackSpeedBonus_Constant( params )
	local passive = 1
	if self:GetParent():PassivesDisabled() then
		passive = 0
	end
	return self:GetStackCount() * self.stack_multiplier * passive
end

--------------------------------------------------------------------------------
-- Helper functions

function modifier_troll_warlord_fervor_lua:AddStack()
	-- check if it is not maximum
	if not self:GetParent():PassivesDisabled() then
		if self:GetStackCount() < self.max_stacks then
			self:IncrementStackCount()
		end
	end
end

function modifier_troll_warlord_fervor_lua:ResetStack()
	if not self:GetParent():PassivesDisabled() then
		self:SetStackCount(1)
	end
end
