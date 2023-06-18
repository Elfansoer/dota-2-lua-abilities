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
modifier_aqua_god_blow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_god_blow:IsHidden()
	return false
end

function modifier_aqua_god_blow:IsDebuff()
	return true
end

function modifier_aqua_god_blow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_god_blow:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )

	if not IsServer() then return end
end

function modifier_aqua_god_blow:OnRefresh( kv )
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )	
end

function modifier_aqua_god_blow:OnRemoved()
end

function modifier_aqua_god_blow:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_aqua_god_blow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_aqua_god_blow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_aqua_god_blow:GetEffectName()
	return "particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf"
end

function modifier_aqua_god_blow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_aqua_god_blow:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_aqua_god_blow:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end