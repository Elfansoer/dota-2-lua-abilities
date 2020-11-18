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
modifier_magnus_empower_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magnus_empower_lua:IsHidden()
	return false
end

function modifier_magnus_empower_lua:IsDebuff()
	return false
end

function modifier_magnus_empower_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magnus_empower_lua:OnCreated( kv )
	self.ability = self:GetAbility()

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_pct" )
	self.cleave = self:GetAbility():GetSpecialValueFor( "cleave_damage_pct" )
	self.mult = self:GetAbility():GetSpecialValueFor( "self_multiplier" )

	self.radius_start = self:GetAbility():GetSpecialValueFor( "cleave_starting_width" )
	self.radius_end = self:GetAbility():GetSpecialValueFor( "cleave_ending_width" )
	self.radius_dist = self:GetAbility():GetSpecialValueFor( "cleave_distance" )

	if self:GetParent()==self:GetCaster() then
		self.damage = self.damage*self.mult
		self.cleave = self.cleave*self.mult
	end

	if not IsServer() then return end

end

function modifier_magnus_empower_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_magnus_empower_lua:OnRemoved()
end

function modifier_magnus_empower_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magnus_empower_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_magnus_empower_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if params.attacker:GetAttackCapability()~=DOTA_UNIT_CAP_MELEE_ATTACK then return end

	local damage = params.damage*self.cleave/100

	-- cleave
	DoCleaveAttack(
		params.attacker,
		params.target,
		self.ability,
		self.cleave,
		self.radius_start,
		self.radius_end,
		self.radius_dist,
		"particles/units/heroes/hero_magnataur/magnataur_empower_cleave_effect.vpcf"
	)
end

function modifier_magnus_empower_lua:GetModifierDamageOutgoing_Percentage()
	return self.damage
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_magnus_empower_lua:GetEffectName()
	return "particles/units/heroes/hero_magnataur/magnataur_empower.vpcf"
end

function modifier_magnus_empower_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end