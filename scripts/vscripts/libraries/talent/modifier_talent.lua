-- Created by Elfansoer
--[[
]]

--------------------------------------------------------------------------------
modifier_talent = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_talent:IsHidden()
	return true
end

function modifier_talent:IsPurgable()
	return false
end

function modifier_talent:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_talent:OnCreated( kv )
	-- if not IsServer() then return end
	-- read kv
	local name = self:GetAbility():GetAbilityName()
	local kv = TalentSystem.kv[name]["AbilitySpecial"]

	self.modified = {}
	self.modified["generic"] = {}
	for k,v in pairs(kv) do
		-- register ability names
		local ability = v["ability"]
		if not self.modified[ability] then
			self.modified[ability] = {}
		end

		-- find special value names
		for key,value in pairs(v) do
			if key~='ability' and key~='var_type' and key~='bonus_type' then
				local temp = {}
				temp.value = value
				temp.type = v["bonus_type"] or '+'
				self.modified[ability][key] = temp
			end
		end
	end

	-- init generics
	self.generics = self.modified["generic"]
	for k,v in pairs(TalentSystem.propertylist) do
		if self.generics[k] then
			self.generics[k] = self.generics[k].value
		else
			self.generics[k] = 0
		end
	end
end

function modifier_talent:OnRefresh( kv )
end

function modifier_talent:OnRemoved()
end

function modifier_talent:OnDestroy()
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_talent:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,

		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
	}
	return funcs
end

function modifier_talent:GetModifierOverrideAbilitySpecial( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	if self.modified[abilityname] and self.modified[abilityname][specialname] then
		return 1
	end

	return 0
end

function modifier_talent:GetModifierOverrideAbilitySpecialValue( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, level )
	local value = self.modified[abilityname][specialname].value
	local bonus_type = self.modified[abilityname][specialname].type

	if bonus_type=='*' then
		return base * value
	else 
		return base + value
	end
end

function modifier_talent:GetModifierBonusStats_Strength()
	return self.generics["str"]
end

function modifier_talent:GetModifierBonusStats_Agility()
	return self.generics["agi"]
end

function modifier_talent:GetModifierBonusStats_Intellect()
	return self.generics["int"]
end

function modifier_talent:GetModifierHealthBonus()
	return self.generics["health"]
end

function modifier_talent:GetModifierManaBonus()
	return self.generics["mana"]
end

function modifier_talent:GetModifierConstantHealthRegen()
	return self.generics["hregen"]
end

function modifier_talent:GetModifierConstantManaRegen()
	return self.generics["mregen"]
end

function modifier_talent:GetModifierPhysicalArmorBonus()
	return self.generics["armor"]
end

function modifier_talent:GetModifierMagicalResistanceBonus()
	return self.generics["magicresist"]
end

function modifier_talent:GetModifierAttackSpeedBonus_Constant()
	return self.generics["attackspeed"]
end

function modifier_talent:GetModifierMoveSpeedBonus_Percentage()
	return self.generics["movespeed"]
end

function modifier_talent:GetModifierPreAttack_BonusDamage()
	return self.generics["attackdamage"]
end

function modifier_talent:GetModifierBaseAttack_BonusDamage()
	return self.generics["basedamage"]
end

function modifier_talent:GetModifierSpellAmplify_Percentage()
	return self.generics["spellamp"]
end

function modifier_talent:GetModifierAttackRangeBonus()
	return self.generics["attackrange"]
end

function modifier_talent:GetModifierCastRangeBonus()
	return self.generics["castrange"]
end

function modifier_talent:GetModifierEvasion_Constant()
	return self.generics["evasion"]
end

function modifier_talent:GetModifierPercentageCooldown()
	return self.generics["cdr"]
end

function modifier_talent:GetBonusNightVision()
	return self.generics["nightvision"]
end