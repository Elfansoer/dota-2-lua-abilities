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
modifier_dawnbreaker_luminosity_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_luminosity_lua:IsHidden()
	return self:GetStackCount()<1
end

function modifier_dawnbreaker_luminosity_lua:IsDebuff()
	return false
end

function modifier_dawnbreaker_luminosity_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_luminosity_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "attack_count" )

	if not IsServer() then return end
end

function modifier_dawnbreaker_luminosity_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dawnbreaker_luminosity_lua:OnRemoved()
end

function modifier_dawnbreaker_luminosity_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_luminosity_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_dawnbreaker_luminosity_lua:GetModifierProcAttack_Feedback( params )
	-- if caster has starbreak, let starbreak do the increase
	if self.parent:HasModifier( "modifier_dawnbreaker_starbreaker_lua" ) then return end
	self:Increment()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_dawnbreaker_luminosity_lua:Increment()
	-- add only if stack < count and not break
	if self.parent:PassivesDisabled() then return end
	if self:GetStackCount()>=self.count then return end

	-- add stack
	self:IncrementStackCount()
	if self:GetStackCount()<self.count then return end

	-- add buff
	local mod = self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_dawnbreaker_luminosity_lua_buff", -- modifier name
		{} -- kv
	)
	mod.modifier = self
end