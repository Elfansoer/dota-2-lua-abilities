modifier_slardar_slithereen_crush_lua_slow = class({})

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua_slow:IsDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua_slow:OnCreated( kv )
	self.ms_slow = self:GetSpecialValueFor("crush_extra_slow")
	self.as_slow = self:GetSpecialValueFor("crush_attack_slow_tooltip")
end

function modifier_slardar_slithereen_crush_lua_slow:OnRefresh( kv )
	self.ms_slow = self:GetSpecialValueFor("crush_extra_slow")
	self.as_slow = self:GetSpecialValueFor("crush_attack_slow_tooltip")
end

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua_slow:GetModifierMoveSpeedBonus_Percentage( params )
	return self.ms_slow
end


function modifier_slardar_slithereen_crush_lua_slow:GetModifierAttackSpeedBonus_Constant( params )
	return self.as_slow
end

--------------------------------------------------------------------------------