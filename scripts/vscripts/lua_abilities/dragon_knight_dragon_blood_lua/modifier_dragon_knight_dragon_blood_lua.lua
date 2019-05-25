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
modifier_dragon_knight_dragon_blood_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_dragon_blood_lua:IsHidden()
	return true
end

function modifier_dragon_knight_dragon_blood_lua:IsDebuff()
	return false
end

function modifier_dragon_knight_dragon_blood_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_dragon_blood_lua:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )
end

function modifier_dragon_knight_dragon_blood_lua:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_health_regen" )	
end

function modifier_dragon_knight_dragon_blood_lua:OnRemoved()
end

function modifier_dragon_knight_dragon_blood_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dragon_knight_dragon_blood_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_dragon_knight_dragon_blood_lua:GetModifierConstantHealthRegen()
	if not self:GetParent():PassivesDisabled() then
		return self.regen
	end
end

function modifier_dragon_knight_dragon_blood_lua:GetModifierPhysicalArmorBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.armor
	end
end