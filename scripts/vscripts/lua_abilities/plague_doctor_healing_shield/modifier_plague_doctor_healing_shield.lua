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
		
		self:SetStackCount(0)
	end
end

function modifier_plague_doctor_healing_shield:OnRefresh( kv )
	if IsServer() then
		self:SetStackCount(0)
	end
end

--------------------------------------------------------------------------------

function modifier_plague_doctor_healing_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE,
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

function modifier_plague_doctor_healing_shield:GetModifierHealAmplify_Percentage( params )

end

--------------------------------------------------------------------------------
function modifier_plague_doctor_healing_shield:AddStack()
	if self
end
