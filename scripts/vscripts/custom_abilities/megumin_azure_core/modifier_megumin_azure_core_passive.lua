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
modifier_megumin_azure_core_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_azure_core_passive:IsHidden()
	return true
end

function modifier_megumin_azure_core_passive:IsDebuff()
	return false
end

function modifier_megumin_azure_core_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_azure_core_passive:OnCreated( kv )
	-- references
	self.base_regen = self:GetAbility():GetSpecialValueFor( "base_regen" )
	self.pct_regen = self:GetAbility():GetSpecialValueFor( "pct_regen" )

	if not IsServer() then return end
end

function modifier_megumin_azure_core_passive:OnRefresh( kv )
	-- references
	self.base_regen = self:GetAbility():GetSpecialValueFor( "base_regen" )
	self.pct_regen = self:GetAbility():GetSpecialValueFor( "pct_regen" )	
end

function modifier_megumin_azure_core_passive:OnRemoved()
end

function modifier_megumin_azure_core_passive:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_megumin_azure_core_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE,
	}

	return funcs
end

function modifier_megumin_azure_core_passive:GetModifierConstantManaRegen()
	return self.base_regen
end

function modifier_megumin_azure_core_passive:GetModifierTotalPercentageManaRegen()
	return self.pct_regen
end