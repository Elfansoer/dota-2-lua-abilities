modifier_ursa_earthshock_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:OnCreated( kv )
	if IsServer() then
		self.slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	end
end

function modifier_ursa_earthshock_lua:OnRefresh( kv )
	if IsServer() then
		self.slow = self:GetAbility():GetSpecialValueFor("movement_slow")
	end
end
--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end
