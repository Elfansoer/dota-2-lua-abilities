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
modifier_fairy_queen_enchantment_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_enchantment_debuff:IsHidden()
	return false
end

function modifier_fairy_queen_enchantment_debuff:IsDebuff()
	return false
end

function modifier_fairy_queen_enchantment_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_enchantment_debuff:OnCreated( kv )
	-- references
	self.bonus = -self:GetAbility():GetSpecialValueFor( "speed_bonus" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	local stun = self:GetAbility():GetSpecialValueFor( "stun_duration" )

	if not IsServer() then return end
	self.thinker = kv.isProvidedByAura~=1
	if self.thinker then return end

	-- stun
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = stun } -- kv
	)
end

function modifier_fairy_queen_enchantment_debuff:OnRefresh( kv )
	-- references
	self.bonus = -self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_fairy_queen_enchantment_debuff:OnRemoved()
end

function modifier_fairy_queen_enchantment_debuff:OnDestroy()
	if not IsServer() then return end
	if self.thinker then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fairy_queen_enchantment_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_fairy_queen_enchantment_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.bonus
end
function modifier_fairy_queen_enchantment_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_fairy_queen_enchantment_debuff:IsAura()
	return self.thinker
end

function modifier_fairy_queen_enchantment_debuff:GetModifierAura()
	return "modifier_fairy_queen_enchantment_debuff"
end

function modifier_fairy_queen_enchantment_debuff:GetAuraRadius()
	return self.radius
end

function modifier_fairy_queen_enchantment_debuff:GetAuraDuration()
	return 0.3
end

function modifier_fairy_queen_enchantment_debuff:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_fairy_queen_enchantment_debuff:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end