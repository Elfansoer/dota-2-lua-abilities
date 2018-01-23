modifier_ursa_fury_swipes_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_lua:IsHidden()
	return true
end

function modifier_ursa_fury_swipes_lua:IsDebuff()
	return false
end

function modifier_ursa_fury_swipes_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_lua:OnCreated( kv )
	if IsServer() then
		-- get reference
		self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
		self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
		self.bonus_reset_time_roshan = self:GetAbility():GetSpecialValueFor("bonus_reset_time_roshan")
	end
end

function modifier_ursa_fury_swipes_lua:OnRefresh( kv )
	if IsServer() then
		-- get reference
		self.damage_per_stack = self:GetAbility():GetSpecialValueFor("damage_per_stack")
		self.bonus_reset_time = self:GetAbility():GetSpecialValueFor("bonus_reset_time")
		self.bonus_reset_time_roshan = self:GetAbility():GetSpecialValueFor("bonus_reset_time_roshan")
	end
end
--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_lua:DeclareFunctions()
	--[[
	todo: find differences between:
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE			GetModifierPreAttack_BonusDamage	
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC		GetModifierPreAttack_BonusDamage_Proc	
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT	GetModifierPreAttack_BonusDamagePostCrit	
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE			GetModifierBaseAttack_BonusDamage	
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL	GetModifierProcAttack_BonusDamage_Physical
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT	GetModifierIncomingPhysicalDamageConstant
	]]

	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_lua:OnAttackLanded( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.attacker==self:GetParent() then
			if not self:GetParent():PassivesDisabled() then
				pass = true
			end
		end

		-- logic
		if pass then
			-- get target (sometimes params.unit, sometimes params.target)
			local target = params.target if target==nil then target = params.unit end

			-- add debuff stack based on target
			local _duration = self.bonus_reset_time

			-- Check if target is Roshan
			if params.target:GetUnitName()=="npc_dota_roshan" then
				_duration = self.bonus_reset_time_roshan
			end

			-- Add or increase stack
			local modifier = target:FindModifierByNameAndCaster("modifier_ursa_fury_swipes_debuff_lua", self:GetAbility():GetCaster())
			if modifier==nil then
				-- add stack
				target:AddNewModifier(
					self:GetAbility():GetCaster(),
					self:GetAbility(),
					"modifier_ursa_fury_swipes_debuff_lua",
					{ duration = _duration }
				)
			else
				-- increase stack
				modifier:IncrementStackCount()
				modifier:ForceRefresh()
			end
		end
	end
end

function modifier_ursa_fury_swipes_lua:GetModifierIncomingPhysicalDamageConstant( params )
	if IsServer() then
		-- filter
		local pass = false
		local target = params.target if target==nil then target = params.unit end
		if params.attacker==self:GetParent() then
			if target:HasModifier("modifier_ursa_fury_swipes_debuff_lua") then
				pass = true
			end
		end

		-- logic
		if pass then
			local modifier = target:FindModifierByNameAndCaster("modifier_ursa_fury_swipes_debuff_lua", self:GetAbility():GetCaster())
			if not modifier==nil then
				local stack = modifier:GetStackCount()
				return stack * self.damage_per_stack
			end
		end
	end
	return 0
end
