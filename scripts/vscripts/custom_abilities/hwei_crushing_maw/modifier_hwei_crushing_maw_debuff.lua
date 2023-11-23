-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_hwei_crushing_maw_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_crushing_maw_debuff:IsHidden()
	return false
end

function modifier_hwei_crushing_maw_debuff:IsDebuff()
	return true
end

function modifier_hwei_crushing_maw_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_crushing_maw_debuff:OnCreated( kv )
	-- references
	self.max_slow = -self:GetAbility():GetSpecialValueFor( "max_slow" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_crushing_maw_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hwei_crushing_maw_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.max_slow * self:GetRemainingTime()/self:GetDuration()
end