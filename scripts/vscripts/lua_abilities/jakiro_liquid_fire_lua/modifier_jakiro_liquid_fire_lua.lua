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
modifier_jakiro_liquid_fire_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_liquid_fire_lua:IsHidden()
	return false
end

function modifier_jakiro_liquid_fire_lua:IsDebuff()
	return true
end

function modifier_jakiro_liquid_fire_lua:IsStunDebuff()
	return false
end

function modifier_jakiro_liquid_fire_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_liquid_fire_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )

	if not IsServer() then return end

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( 0.5 )
end

function modifier_jakiro_liquid_fire_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )

	if not IsServer() then return end

	-- update damage
	self.damageTable.damage = damage	
end

function modifier_jakiro_liquid_fire_lua:OnRemoved()
end

function modifier_jakiro_liquid_fire_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_jakiro_liquid_fire_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_jakiro_liquid_fire_lua:GetModifierAttackSpeedBonus_Constant()
	return self.slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_jakiro_liquid_fire_lua:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_liquid_fire_lua:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_liquid_fire_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end