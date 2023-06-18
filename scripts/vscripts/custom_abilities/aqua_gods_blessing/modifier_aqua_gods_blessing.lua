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
modifier_aqua_gods_blessing = class({})

local random_funcs = {
	[0] = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	},
	[1] = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	},
	[2] = {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	},
	[3] = {
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	},
	[4] = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	},
	[5] = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
}

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_gods_blessing:IsHidden()
	return false
end

function modifier_aqua_gods_blessing:IsDebuff()
	return self.is_enemy
end

function modifier_aqua_gods_blessing:IsPurgable()
	return true
end

function modifier_aqua_gods_blessing:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_gods_blessing:OnCreated( kv )
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	-- caster is the thinker, not real caster
	self.caster = self.ability:GetCaster()

	self.is_enemy = self.parent:GetTeamNumber()~=self.caster:GetTeamNumber()
	self.tick = 0.1

	local mult = 1
	if self.is_enemy then
		mult = -1
	end
	if not self.parent:IsHero() then
		mult = mult * 2
	end
	
	self.ms_bonus = mult * self.ability:GetSpecialValueFor( "ms_bonus" )
	self.as_bonus = mult * self.ability:GetSpecialValueFor( "as_bonus" )
	self.armor_bonus = mult * self.ability:GetSpecialValueFor( "armor_bonus" )
	self.magic_resist_bonus = mult * self.ability:GetSpecialValueFor( "magic_resist_bonus" )
	self.damage_bonus = mult * self.ability:GetSpecialValueFor( "damage_bonus" )
	self.spell_amp_bonus = mult * self.ability:GetSpecialValueFor( "spell_amp_bonus" )
	self.health_bonus = mult * self.ability:GetSpecialValueFor( "health_bonus" )
	self.mana_bonus = mult * self.ability:GetSpecialValueFor( "mana_bonus" )
	self.hp_regen_bonus = mult * self.ability:GetSpecialValueFor( "hp_regen_bonus" )
	self.mp_regen_bonus = mult * self.ability:GetSpecialValueFor( "mp_regen_bonus" )
	self.stat_bonus = mult * self.ability:GetSpecialValueFor( "stat_bonus" )
	
	-- references
	if not IsServer() then return end
	self:SetStackCount( self.random + 1 )
	
	-- Start interval for enemy damage
	if self.is_enemy and self.random == 2 then
		self.damageTable = {
			victim = self.parent,
			attacker = self.caster,
			damage = -self.hp_regen_bonus * self.tick,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self.ability,
			damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN
		}

		self:StartIntervalThink( self.tick )
		self:OnIntervalThink()
	end
end

function modifier_aqua_gods_blessing:OnRefresh( kv )
end

function modifier_aqua_gods_blessing:OnRemoved()
end

function modifier_aqua_gods_blessing:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- this is called before OnCreated and Transmitter
function modifier_aqua_gods_blessing:DeclareFunctions()
	-- caster is the thinker, not real caster
	self.random = self:GetCaster().random
	if not self:GetParent():IsHero() then
		self.random = self.random % 3
	end

	return random_funcs[ self.random ]
end

function modifier_aqua_gods_blessing:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

function modifier_aqua_gods_blessing:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

function modifier_aqua_gods_blessing:GetModifierPhysicalArmorBonus()
	return self.armor_bonus
end

function modifier_aqua_gods_blessing:GetModifierMagicalResistanceBonus()
	return self.magic_resist_bonus
end

function modifier_aqua_gods_blessing:GetModifierDamageOutgoing_Percentage()
	return self.damage_bonus
end

function modifier_aqua_gods_blessing:GetModifierSpellAmplify_Percentage()
	return self.spell_amp_bonus
end

function modifier_aqua_gods_blessing:GetModifierHealthBonus()
	return self.health_bonus
end

function modifier_aqua_gods_blessing:GetModifierConstantHealthRegen()
	if self.is_enemy then return 0 end
	return self.hp_regen_bonus
end

function modifier_aqua_gods_blessing:GetModifierManaBonus()
	return self.mana_bonus
end

function modifier_aqua_gods_blessing:GetModifierConstantManaRegen()
	return self.mp_regen_bonus
end

function modifier_aqua_gods_blessing:GetModifierBonusStats_Strength()
	return self:StatBonus( DOTA_ATTRIBUTE_STRENGTH )
end

function modifier_aqua_gods_blessing:GetModifierBonusStats_Agility()
	return self:StatBonus( DOTA_ATTRIBUTE_AGILITY )
end

function modifier_aqua_gods_blessing:GetModifierBonusStats_Intellect()
	return self:StatBonus( DOTA_ATTRIBUTE_INTELLECT )
end

function modifier_aqua_gods_blessing:StatBonus( attribute )
	local parent_stat = self.parent:GetPrimaryAttribute()
	if parent_stat==attribute then
		return self.stat_bonus
	elseif parent_stat==DOTA_ATTRIBUTE_ALL then
		return math.floor( self.stat_bonus/3 )
	else
		return 0
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_aqua_gods_blessing:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_aqua_gods_blessing:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
end

function modifier_aqua_gods_blessing:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end