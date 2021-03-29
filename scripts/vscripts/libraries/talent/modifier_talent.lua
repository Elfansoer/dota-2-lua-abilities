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

	self.specials = {}
	for k,v in pairs(kv) do
		table.insert( self.specials, v )
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
	}

	return funcs
end

function modifier_talent:GetModifierOverrideAbilitySpecial( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	for _,special in pairs(self.specials) do
		if abilityname==special.ability and special[specialname] then
			return 1
		end
	end

	return 0
end

function modifier_talent:GetModifierOverrideAbilitySpecialValue( params )
	local abilityname = params.ability:GetAbilityName()
	local specialname = params.ability_special_value
	local level = params.ability_special_level

	local value = 0
	local bonus_type = '+'
	for _,special in pairs(self.specials) do
		if abilityname==special.ability and special[specialname] then
			value = special[specialname]
			bonus_type = special.bonus_type
		end
	end

	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, level )
	if bonus_type=='*' then
		return base * value
	else 
		return base + value
	end
end