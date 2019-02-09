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
modifier_luna_moon_glaive_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_luna_moon_glaive_lua:IsHidden()
	return true
end

function modifier_luna_moon_glaive_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_luna_moon_glaive_lua:OnCreated( kv )
	-- references
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounces" )
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_percent" )
	self.ability = self:GetAbility()
end

function modifier_luna_moon_glaive_lua:OnRefresh( kv )
	-- references
	self.bounces = self:GetAbility():GetSpecialValueFor( "bounces" )
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "damage_reduction_percent" )
end

function modifier_luna_moon_glaive_lua:OnRemoved()
end

function modifier_luna_moon_glaive_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_luna_moon_glaive_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_luna_moon_glaive_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end

	-- cancel if break
	if self:GetParent():PassivesDisabled() then return end

	-- create thinker
	CreateModifierThinker(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_luna_moon_glaive_lua_thinker", -- modifier name
		{  }, -- kv
		params.target:GetOrigin(),
		self:GetParent():GetTeamNumber(),
		false
	)
end

function modifier_luna_moon_glaive_lua:GetModifierDamageOutgoing_Percentage()
	return self.ability.outgoing or 0
end