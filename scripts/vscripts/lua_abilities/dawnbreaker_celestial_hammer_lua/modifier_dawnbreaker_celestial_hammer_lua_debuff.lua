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
modifier_dawnbreaker_celestial_hammer_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_celestial_hammer_lua_debuff:IsHidden()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:IsDebuff()
	return true
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_celestial_hammer_lua_debuff:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "burn_damage" )
	self.interval = self:GetAbility():GetSpecialValueFor( "burn_interval" )
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage*self.interval,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:OnRefresh( kv )
	
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:OnRemoved()
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_celestial_hammer_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_celestial_hammer_lua_debuff:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_celestial_hammer_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_debuff.vpcf"
end

function modifier_dawnbreaker_celestial_hammer_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end