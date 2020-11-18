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
modifier_terrorblade_metamorphosis_lua_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_metamorphosis_lua_aura:IsHidden()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsStunDebuff()
	return false
end

function modifier_terrorblade_metamorphosis_lua_aura:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_metamorphosis_lua_aura:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "metamorph_aura_tooltip" )

	if not IsServer() then return end
end

function modifier_terrorblade_metamorphosis_lua_aura:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_terrorblade_metamorphosis_lua_aura:OnRemoved()
end

function modifier_terrorblade_metamorphosis_lua_aura:OnDestroy()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_terrorblade_metamorphosis_lua_aura:IsAura()
	return true
end

function modifier_terrorblade_metamorphosis_lua_aura:GetModifierAura()
	return "modifier_terrorblade_metamorphosis_lua"
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraRadius()
	return self.radius
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraDuration()
	return 1
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraSearchFlags()
	return 0
end

function modifier_terrorblade_metamorphosis_lua_aura:GetAuraEntityReject( hEntity )
	if IsServer() then
		if hEntity:GetPlayerOwnerID()~=self:GetParent():GetPlayerOwnerID() then
			return true
		end
	end

	return false
end