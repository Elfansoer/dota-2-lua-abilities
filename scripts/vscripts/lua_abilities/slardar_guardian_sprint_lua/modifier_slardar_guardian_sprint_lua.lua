modifier_slardar_guardian_sprint_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slardar_guardian_sprint_lua:IsHidden()
	return false
end

function modifier_slardar_guardian_sprint_lua:IsDebuff()
	return false
end

function modifier_slardar_guardian_sprint_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slardar_guardian_sprint_lua:OnCreated( kv )
	-- references
	self.bonus_speed = self:GetAbility():GetSpecialValueFor( "bonus_speed" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.river_speed = self:GetAbility():GetSpecialValueFor( "river_speed" )
end

function modifier_slardar_guardian_sprint_lua:OnRefresh( kv )
	-- references
	self.bonus_speed = self:GetAbility():GetSpecialValueFor( "bonus_speed" )
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.river_speed = self:GetAbility():GetSpecialValueFor( "river_speed" )
end

function modifier_slardar_guardian_sprint_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slardar_guardian_sprint_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end

function modifier_slardar_guardian_sprint_lua:GetModifierIncomingDamage_Percentage()
	return self.bonus_damage
end
function modifier_slardar_guardian_sprint_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_speed
end
function modifier_slardar_guardian_sprint_lua:GetModifierMoveSpeed_Absolute() {
	-- check if in the river
	if false then
		return self.river_speed
	end
}
--------------------------------------------------------------------------------
-- Status Effects
function modifier_slardar_guardian_sprint_lua:CheckState()
	local state = {
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_slardar_guardian_sprint_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_slardar_guardian_sprint_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
