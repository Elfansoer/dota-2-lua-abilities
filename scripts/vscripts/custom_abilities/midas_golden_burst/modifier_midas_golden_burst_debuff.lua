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
modifier_midas_golden_burst_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_burst_debuff:IsHidden()
	return false
end

function modifier_midas_golden_burst_debuff:IsDebuff()
	return true
end

function modifier_midas_golden_burst_debuff:IsStunDebuff()
	return false
end

function modifier_midas_golden_burst_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_burst_debuff:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_midas_golden_burst_debuff:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_midas_golden_burst_debuff:OnRemoved()
end

function modifier_midas_golden_burst_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_burst_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_midas_golden_burst_debuff:GetModifierPhysicalArmorBonus()
	return -self.armor
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_midas_golden_burst_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_MUTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_midas_golden_burst_debuff:GetEffectName()
	return "particles/midas_golden_burst_debuff.vpcf"
end

function modifier_midas_golden_burst_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end