modifier_enchantress_enchant_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enchantress_enchant_lua_slow:IsHidden()
	return false
end

function modifier_enchantress_enchant_lua_slow:IsDebuff()
	return true
end

function modifier_enchantress_enchant_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enchantress_enchant_lua_slow:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_enchantress_enchant_lua_slow:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" ) -- special value
end

function modifier_enchantress_enchant_lua_slow:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_enchantress_enchant_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_enchantress_enchant_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_enchantress_enchant_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_enchantress/enchantress_enchant_slow.vpcf"
end

function modifier_enchantress_enchant_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end