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
modifier_timbersaw_reactive_armor_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_reactive_armor_lua:IsHidden()
	return self:GetStackCount()==0
end

function modifier_timbersaw_reactive_armor_lua:IsDebuff()
	return false
end

function modifier_timbersaw_reactive_armor_lua:IsStunDebuff()
	return false
end

function modifier_timbersaw_reactive_armor_lua:IsPurgable()
	return false
end

function modifier_timbersaw_reactive_armor_lua:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_reactive_armor_lua:OnCreated( kv )
	-- references
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.stack_regen = self:GetAbility():GetSpecialValueFor( "bonus_hp_regen" )
	self.stack_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )

	self.actual_stack = 0
end

function modifier_timbersaw_reactive_armor_lua:OnRefresh( kv )
	-- references
	self.stack_duration = self:GetAbility():GetSpecialValueFor( "stack_duration" )
	self.stack_limit = self:GetAbility():GetSpecialValueFor( "stack_limit" )
	self.stack_regen = self:GetAbility():GetSpecialValueFor( "bonus_hp_regen" )
	self.stack_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
end

function modifier_timbersaw_reactive_armor_lua:OnRemoved()
end

function modifier_timbersaw_reactive_armor_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_timbersaw_reactive_armor_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED,

		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_timbersaw_reactive_armor_lua:OnAttackLanded( params )
	if not IsServer() then return end
	if params.target~=self:GetParent() then return end

	-- cancel if break
	if self:GetParent():PassivesDisabled() then return end

	-- add stack
	self.actual_stack = self.actual_stack + 1
	if self:GetStackCount()<self.stack_limit then
		self:IncrementStackCount()
	end

	-- add stack modifier
	local modifier = self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_timbersaw_reactive_armor_lua_stack", -- modifier name
		{ duration = self.stack_duration } -- kv
	)
	modifier.parent = self

	-- set duration
	self:SetDuration( self.stack_duration, true )
end

function modifier_timbersaw_reactive_armor_lua:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * self.stack_armor
end
function modifier_timbersaw_reactive_armor_lua:GetModifierConstantHealthRegen()
	return self:GetStackCount() * self.stack_regen
end

function modifier_timbersaw_reactive_armor_lua:RemoveStack()
	self.actual_stack = self.actual_stack - 1
	if self.actual_stack<=self.stack_limit then
		self:SetStackCount( self.actual_stack )
	end
end