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
modifier_midas_golden_valkyrie_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_valkyrie_buff:IsHidden()
	return false
end

function modifier_midas_golden_valkyrie_buff:IsDebuff()
	return false
end

function modifier_midas_golden_valkyrie_buff:IsPurgable()
	return false
end

function modifier_midas_golden_valkyrie_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_valkyrie_buff:OnCreated( kv )
	self.ability = self:GetAbility()
end

function modifier_midas_golden_valkyrie_buff:OnRemoved()
end

function modifier_midas_golden_valkyrie_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_midas_golden_valkyrie_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_midas_golden_valkyrie_buff:GetModifierDamageOutgoing_Percentage()
	return self.ability.outgoing or 0
end