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
modifier_megumin_crimson_core_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_crimson_core_passive:IsHidden()
	return true
end

function modifier_megumin_crimson_core_passive:IsDebuff()
	return false
end

function modifier_megumin_crimson_core_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_crimson_core_passive:OnCreated( kv )
	self.ability = self:GetAbility()

	-- references
	self.flat_mana = self:GetAbility():GetSpecialValueFor( "flat_mana" )
	self.pct_mana = self:GetAbility():GetSpecialValueFor( "pct_mana" )

	if not IsServer() then return end
end

function modifier_megumin_crimson_core_passive:OnRefresh( kv )
	-- references
	self.flat_mana = self:GetAbility():GetSpecialValueFor( "flat_mana" )
	self.pct_mana = self:GetAbility():GetSpecialValueFor( "pct_mana" )
end

function modifier_megumin_crimson_core_passive:OnRemoved()
end

function modifier_megumin_crimson_core_passive:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_megumin_crimson_core_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_MANA_BONUS,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
	}

	return funcs
end

function modifier_megumin_crimson_core_passive:GetModifierExtraManaBonus()
	return self.flat_mana
end

function modifier_megumin_crimson_core_passive:GetModifierExtraManaPercentage()
	return self.pct_mana
end