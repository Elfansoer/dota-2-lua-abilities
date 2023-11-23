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
modifier_hwei_fleeting_current = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_fleeting_current:IsHidden()
	return false
end

function modifier_hwei_fleeting_current:IsDebuff()
	return false
end

function modifier_hwei_fleeting_current:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_fleeting_current:OnCreated( kv )
	-- references
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "ms_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_fleeting_current:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hwei_fleeting_current:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hwei_fleeting_current:CheckState()
	local state = {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_fleeting_current:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun.vpcf"
end

function modifier_hwei_fleeting_current:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end