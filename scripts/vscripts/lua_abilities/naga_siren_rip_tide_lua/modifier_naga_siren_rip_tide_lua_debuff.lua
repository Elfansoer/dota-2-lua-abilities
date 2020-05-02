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
modifier_naga_siren_rip_tide_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_rip_tide_lua_debuff:IsHidden()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsDebuff()
	return true
end

function modifier_naga_siren_rip_tide_lua_debuff:IsStunDebuff()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_rip_tide_lua_debuff:OnCreated( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
	if not IsServer() then return end
end

function modifier_naga_siren_rip_tide_lua_debuff:OnRefresh( kv )
	-- references
	self.armor = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
	if not IsServer() then return end
end

function modifier_naga_siren_rip_tide_lua_debuff:OnRemoved()
end

function modifier_naga_siren_rip_tide_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_naga_siren_rip_tide_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_naga_siren_rip_tide_lua_debuff:GetModifierPhysicalArmorBonus()
	return self.armor
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_naga_siren_rip_tide_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf"
end

function modifier_naga_siren_rip_tide_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end