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
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- get target
		local target = params.target if target==nil then target = params.unit end

		-- get modifier stack
		local stack = 0
		local modifier = target:FindModifierByNameAndCaster("modifier_ursa_fury_swipes_debuff_lua", self:GetAbility():GetCaster())

		-- add stack if not
		if modifier==nil then
			-- if does not have break
			if not self:GetParent():PassivesDisabled() then
				-- determine duration if roshan/not
				local _duration = self.bonus_reset_time
				if params.target:GetUnitName()=="npc_dota_roshan" then
					_duration = self.bonus_reset_time_roshan
				end

				-- add modifier
				target:AddNewModifier(
					self:GetAbility():GetCaster(),
					self:GetAbility(),
					"modifier_ursa_fury_swipes_debuff_lua",
					{ duration = _duration }
				)

				-- get stack number
				stack = 1
			end
		else
			-- increase stack
			modifier:IncrementStackCount()
			modifier:ForceRefresh()

			-- get stack number
			stack = modifier:GetStackCount()
		end

		-- return damage bonus
		return stack * self.damage_per_stack
	end
end
