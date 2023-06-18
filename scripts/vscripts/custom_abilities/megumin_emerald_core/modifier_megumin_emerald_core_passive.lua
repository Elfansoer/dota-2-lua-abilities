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
modifier_megumin_emerald_core_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_emerald_core_passive:IsHidden()
	return true
end

function modifier_megumin_emerald_core_passive:IsDebuff()
	return false
end

function modifier_megumin_emerald_core_passive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_emerald_core_passive:OnCreated( kv )
	self.ability = self:GetAbility()

	-- references
	self.damage_stun = self:GetAbility():GetSpecialValueFor( "damage_stun" )

	if not IsServer() then return end
end

function modifier_megumin_emerald_core_passive:OnRefresh( kv )
	-- references
	self.damage_stun = self:GetAbility():GetSpecialValueFor( "damage_stun" )
end

function modifier_megumin_emerald_core_passive:OnRemoved()
end

function modifier_megumin_emerald_core_passive:OnDestroy()
end

-- --------------------------------------------------------------------------------
-- -- Modifier Effects
-- function modifier_megumin_emerald_core_passive:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
-- 		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
-- 	}

-- 	return funcs
-- end

-- function modifier_megumin_emerald_core_passive:GetModifierOverrideAbilitySpecial( params )
-- 	if params.ability:GetAbilityName() ~= "megumin_explosion" then return 0 end
	
-- 	local specialname = params.ability_special_value
-- 	if specialname == "green_damage_stun" then return 1 end

-- 	return 0
-- end

-- function modifier_megumin_emerald_core_passive:GetModifierOverrideAbilitySpecialValue( params )
-- 	local specialname = params.ability_special_value

-- 	local base = params.ability:GetLevelSpecialValueNoOverride( specialname, params.ability:GetLevel() )
-- 	local bonus = self.damage_stun

-- 	return base + bonus
-- end
