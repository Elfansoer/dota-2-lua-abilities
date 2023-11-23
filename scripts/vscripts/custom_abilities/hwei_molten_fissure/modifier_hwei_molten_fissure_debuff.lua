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
modifier_hwei_molten_fissure_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_molten_fissure_debuff:IsHidden()
	return false
end

function modifier_hwei_molten_fissure_debuff:IsDebuff()
	return true
end

function modifier_hwei_molten_fissure_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_molten_fissure_debuff:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "dps" )
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )
	self.interval = self:GetAbility():GetSpecialValueFor( "interval" )
	
	if not IsServer() then return end

	self.damage_type = self.ability:GetAbilityDamageType()

	-- precache damage
	self.damageTable = {
		victim = self.parent,
		attacker = self.caster,
		damage = self.damage*self.interval,
		damage_type = self.damage_type,
		ability = self.ability, --Optional.
	}

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_molten_fissure_debuff:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_molten_fissure_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hwei_molten_fissure_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_molten_fissure_debuff:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_hwei_molten_fissure_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end