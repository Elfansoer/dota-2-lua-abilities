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
modifier_fairy_queen_enchantment = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_enchantment:IsHidden()
	return false
end

function modifier_fairy_queen_enchantment:IsDebuff()
	return false
end

function modifier_fairy_queen_enchantment:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_enchantment:OnCreated( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	
	if not IsServer() then return end
	self.thinker = kv.isProvidedByAura~=1

	-- strong dispel
	self:GetParent():Purge( false, true, false, true, true )
end

function modifier_fairy_queen_enchantment:OnRefresh( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "speed_bonus" )
end

function modifier_fairy_queen_enchantment:OnRemoved()
end

function modifier_fairy_queen_enchantment:OnDestroy()
	if not IsServer() then return end
	if self.thinker then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fairy_queen_enchantment:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_fairy_queen_enchantment:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_fairy_queen_enchantment:IsAura()
	return self.thinker
end

function modifier_fairy_queen_enchantment:GetModifierAura()
	return "modifier_fairy_queen_enchantment"
end

function modifier_fairy_queen_enchantment:GetAuraRadius()
	return self.radius
end

function modifier_fairy_queen_enchantment:GetAuraDuration()
	return 0.3
end

function modifier_fairy_queen_enchantment:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_fairy_queen_enchantment:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end