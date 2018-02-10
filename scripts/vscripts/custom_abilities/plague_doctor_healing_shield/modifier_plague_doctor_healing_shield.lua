modifier_plague_doctor_healing_shield = class({})

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield:IsHidden()
	return false
end

function modifier_plague_doctor_healing_shield:IsDebuff()
	return false
end

function modifier_plague_doctor_healing_shield:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield:OnCreated( kv )
	if IsServer() then
		-- get references
		self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")
		self.stack_max = self:GetAbility():GetSpecialValueFor("stack_max")

		self:SetStackCount(0)
	end
end

function modifier_plague_doctor_healing_shield:OnRefresh( kv )
	if IsServer() then
		self.stack_duration = self:GetAbility():GetSpecialValueFor("stack_duration")
		self.stack_max = self:GetAbility():GetSpecialValueFor("stack_max")

		self:SetStackCount(0)
	end
end

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield:OnTakeDamage( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			if not self:GetParent():PassivesDisabled() then
				if self:GetAbility():IsCooldownReady() then
					-- check if it is sourced from ability
					if params.inflictor~=nil then
						pass = true
					end
				end
			end
		end
		
		-- logic
		if pass then
			self:AddStack()
		end
	end
end

--------------------------------------------------------------------------------
function modifier_plague_doctor_healing_shield:AddStack()
	-- check if maximum
	if self:GetStackCount() < self.stack_max then
		-- get modifier key
		local modifier_key = self:GetAbility():AddATValue(self)

		-- add modifier
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_plague_doctor_healing_shield_stack",
			{
				duration = self.stack_duration,
				modifier = modifier_key
			}
		)

		-- add stack
		self:IncrementStackCount()

		-- set on cooldown
		self:GetAbility():StartCooldown(self:GetAbility():GetCooldown(-1))	
	end
end

function modifier_plague_doctor_healing_shield:MinStack()
	self:DecrementStackCount()
end
