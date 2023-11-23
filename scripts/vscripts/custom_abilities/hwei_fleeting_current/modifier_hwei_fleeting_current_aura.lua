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
modifier_hwei_fleeting_current_aura = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_fleeting_current_aura:OnCreated( kv )
	-- references
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.linger = 0.1
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_hwei_fleeting_current_aura:IsAura()
	return true
end

function modifier_hwei_fleeting_current_aura:GetModifierAura()
	return "modifier_hwei_fleeting_current"
end

function modifier_hwei_fleeting_current_aura:GetAuraRadius()
	return self.width
end

function modifier_hwei_fleeting_current_aura:GetAuraDuration()
	return self.linger
end

function modifier_hwei_fleeting_current_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_hwei_fleeting_current_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end