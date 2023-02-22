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
modifier_sally_quadruple_slash = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_quadruple_slash:IsHidden()
	return true
end

function modifier_sally_quadruple_slash:IsDebuff()
	return false
end

function modifier_sally_quadruple_slash:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_quadruple_slash:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.reduction = -self:GetAbility():GetSpecialValueFor( "damage_reduction" )

	if not IsServer() then return end
	self.records = {}
	self.proc_attack = false
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_generic_orb_effect_lua",
		{}
	)
end

function modifier_sally_quadruple_slash:OnRefresh( kv )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
	self.reduction = -self:GetAbility():GetSpecialValueFor( "damage_reduction" )
end

function modifier_sally_quadruple_slash:OnRemoved()
end

function modifier_sally_quadruple_slash:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_quadruple_slash:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE ,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
	}

	return funcs
end

function modifier_sally_quadruple_slash:GetModifierProcAttack_Feedback( params )
	if self.records[params.record] then
		params.target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_sally_quadruple_slash_debuff",
			{duration = self.duration}
		)
		self.proc_attack = true
	end
end

function modifier_sally_quadruple_slash:GetModifierTotalDamageOutgoing_Percentage( params )
	if self.records[params.record] then
		return self.reduction
	end
end

function modifier_sally_quadruple_slash:OnAttackRecordDestroy( params )
	self.records[params.record] = nil
end

--------------------------------------------------------------------------------
-- helper
function modifier_sally_quadruple_slash:RegisterAttack( record )
	self.records[record] = true
end