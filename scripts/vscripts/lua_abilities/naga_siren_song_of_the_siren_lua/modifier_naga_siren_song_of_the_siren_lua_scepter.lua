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
modifier_naga_siren_song_of_the_siren_lua_scepter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_song_of_the_siren_lua_scepter:IsHidden()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:IsDebuff()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:IsPurgable()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_song_of_the_siren_lua_scepter:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.regen = self:GetAbility():GetSpecialValueFor( "regen_rate" )
	self.regen_self = self:GetAbility():GetSpecialValueFor( "regen_rate_self" )

	if not IsServer() then return end
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.regen = self:GetAbility():GetSpecialValueFor( "regen_rate" )
	self.regen_self = self:GetAbility():GetSpecialValueFor( "regen_rate_self" )

	if not IsServer() then return end	
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:OnRemoved()
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_naga_siren_song_of_the_siren_lua_scepter:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}

	return funcs
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetModifierHealthRegenPercentage()
	if self:GetParent()==self:GetCaster() then
		return self.regen_self
	end

	return self.regen
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_naga_siren_song_of_the_siren_lua_scepter:IsAura()
	-- only as owner
	return self:GetParent()==self:GetCaster()
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetModifierAura()
	return "modifier_naga_siren_song_of_the_siren_lua_scepter"
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraRadius()
	return self.radius
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraDuration()
	return 0.4
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_naga_siren_song_of_the_siren_lua_scepter:GetAuraEntityReject( hEntity )
	return false
end