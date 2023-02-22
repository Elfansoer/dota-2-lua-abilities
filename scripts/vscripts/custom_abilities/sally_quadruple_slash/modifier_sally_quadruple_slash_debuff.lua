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
modifier_sally_quadruple_slash_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_quadruple_slash_debuff:IsHidden()
	return false
end

function modifier_sally_quadruple_slash_debuff:IsDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_quadruple_slash_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "ms_slow" )

	if not IsServer() then return end
end

function modifier_sally_quadruple_slash_debuff:OnRefresh( kv )
	self.slow = -self:GetAbility():GetSpecialValueFor( "ms_slow" )
end

function modifier_sally_quadruple_slash_debuff:OnRemoved()
end

function modifier_sally_quadruple_slash_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_quadruple_slash_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_sally_quadruple_slash_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sally_quadruple_slash_debuff:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_unleash_pulse_debuff.vpcf"
end

function modifier_sally_quadruple_slash_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_sally_quadruple_slash_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_sally_quadruple_slash_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end