modifier_ursa_earthshock_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_ursa_earthshock_lua:OnCreated( kv )
	self.slow = self:GetAbility():GetSpecialValueFor("movement_slow")
end

function modifier_ursa_earthshock_lua:OnRefresh( kv )
	self.slow = self:GetAbility():GetSpecialValueFor("movement_slow")
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

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_ursa_earthshock_lua:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf"
end

function modifier_ursa_earthshock_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end