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
modifier_venomancer_poison_sting_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_venomancer_poison_sting_lua:IsHidden()
	return true
end

function modifier_venomancer_poison_sting_lua:IsDebuff()
	return false
end

function modifier_venomancer_poison_sting_lua:IsStunDebuff()
	return false
end

function modifier_venomancer_poison_sting_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_venomancer_poison_sting_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.team = self:GetCaster():GetTeamNumber()

	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
end

function modifier_venomancer_poison_sting_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_venomancer_poison_sting_lua:OnRemoved()
end

function modifier_venomancer_poison_sting_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_venomancer_poison_sting_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_venomancer_poison_sting_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if self.caster:PassivesDisabled() then return end

	local filter = UnitFilter(
		params.target,
		self.abilityTargetTeam,
		self.abilityTargetType,
		self.abilityTargetFlags,
		self.team
	)
	if not filter==UF_SUCCESS then return end

	-- apply debuff
	params.target:AddNewModifier(
		self.caster, -- player source
		self.ability, -- ability source
		"modifier_venomancer_poison_sting_lua_debuff", -- modifier name
		{ duration = self.duration } -- kv
	)
end
