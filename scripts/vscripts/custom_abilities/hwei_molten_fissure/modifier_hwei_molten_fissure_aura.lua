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
modifier_hwei_molten_fissure_aura = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_molten_fissure_aura:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger" )

	if not IsServer() then return end
end

function modifier_hwei_molten_fissure_aura:OnRefresh( kv )
	
end

function modifier_hwei_molten_fissure_aura:OnRemoved()
end

function modifier_hwei_molten_fissure_aura:OnDestroy()
	if not IsServer() then return end

	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_hwei_molten_fissure_aura:IsAura()
	return true
end

function modifier_hwei_molten_fissure_aura:GetModifierAura()
	return "modifier_hwei_molten_fissure_debuff"
end

function modifier_hwei_molten_fissure_aura:GetAuraRadius()
	return self.width
end

function modifier_hwei_molten_fissure_aura:GetAuraDuration()
	return self.linger
end

function modifier_hwei_molten_fissure_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_hwei_molten_fissure_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_hwei_molten_fissure_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end