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
modifier_viper_viper_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_viper_strike_lua:IsHidden()
	return false
end

function modifier_viper_viper_strike_lua:IsDebuff()
	return true
end

function modifier_viper_viper_strike_lua:IsStunDebuff()
	return false
end

function modifier_viper_viper_strike_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_viper_strike_lua:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	self.start_time = GameRules:GetGameTime()
	self.duration = kv.duration

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
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_viper_viper_strike_lua:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )

	self.start_time = GameRules:GetGameTime()
	self.duration = kv.duration
	
	if not IsServer() then return end
	-- update damage
	self.damageTable.damage = damage

	-- restart interval tick
	self:StartIntervalThink( 1 )
	self:OnIntervalThink()
end

function modifier_viper_viper_strike_lua:OnRemoved()
end

function modifier_viper_viper_strike_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_viper_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_viper_viper_strike_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow * ( 1 - ( GameRules:GetGameTime()-self.start_time )/self.duration )
end
function modifier_viper_viper_strike_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow * ( 1 - ( GameRules:GetGameTime()-self.start_time )/self.duration )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_viper_viper_strike_lua:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_viper_viper_strike_lua:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_viper_strike_debuff.vpcf"
end

function modifier_viper_viper_strike_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_viper_viper_strike_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_poison_viper.vpcf"
end

function modifier_viper_viper_strike_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_HIGH
end
