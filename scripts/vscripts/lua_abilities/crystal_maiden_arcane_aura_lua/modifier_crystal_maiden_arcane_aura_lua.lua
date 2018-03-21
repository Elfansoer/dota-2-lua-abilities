modifier_crystal_maiden_arcane_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_crystal_maiden_arcane_aura_lua:IsHidden()
	return true
end

function modifier_crystal_maiden_arcane_aura_lua:IsDebuff()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------
-- Aura
function modifier_crystal_maiden_arcane_aura_lua:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_crystal_maiden_arcane_aura_lua:GetModifierAura()
	return "modifier_crystal_maiden_arcane_aura_lua_effect"
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraRadius()
	return FIND_UNITS_EVERYWHERE
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end