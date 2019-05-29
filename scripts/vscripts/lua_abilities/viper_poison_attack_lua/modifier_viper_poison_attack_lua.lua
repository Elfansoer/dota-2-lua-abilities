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
modifier_viper_poison_attack_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_viper_poison_attack_lua:IsHidden()
	return false
end

function modifier_viper_poison_attack_lua:IsDebuff()
	return true
end

function modifier_viper_poison_attack_lua:IsStunDebuff()
	return false
end

function modifier_viper_poison_attack_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_viper_poison_attack_lua:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "damage" )

	if not IsServer() then return end
	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		-- damage = 500,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( 1 )
end

function modifier_viper_poison_attack_lua:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed" )
	self.damage_pct = self:GetAbility():GetSpecialValueFor( "damage" )
end

function modifier_viper_poison_attack_lua:OnRemoved()
end

function modifier_viper_poison_attack_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_viper_poison_attack_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_viper_poison_attack_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end
function modifier_viper_poison_attack_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_viper_poison_attack_lua:OnIntervalThink()
	-- set damage based on missing health pct
	local miss_health = 100-self:GetParent():GetHealthPercent()
	self.damageTable.damage = miss_health*self.damage_pct

	-- Apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_viper_poison_attack_lua:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_poison_debuff.vpcf"
end

function modifier_viper_poison_attack_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end