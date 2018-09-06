modifier_lich_frost_armor_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lich_frost_armor_lua_debuff:IsHidden()
	return false
end

function modifier_lich_frost_armor_lua_debuff:IsDebuff()
	return true
end

function modifier_lich_frost_armor_lua_debuff:IsStunDebuff()
	return false
end

function modifier_lich_frost_armor_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lich_frost_armor_lua_debuff:OnCreated( kv )
	-- references
	self.as_slow = kv.as_slow
	self.ms_slow = kv.ms_slow
end

function modifier_lich_frost_armor_lua_debuff:OnRefresh( kv )
	-- references
	self.as_slow = kv.as_slow
	self.ms_slow = kv.ms_slow	
end

function modifier_lich_frost_armor_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lich_frost_armor_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_lich_frost_armor_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end
function modifier_lich_frost_armor_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lich_frost_armor_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end