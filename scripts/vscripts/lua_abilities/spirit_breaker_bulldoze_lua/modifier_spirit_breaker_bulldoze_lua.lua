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
modifier_spirit_breaker_bulldoze_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spirit_breaker_bulldoze_lua:IsHidden()
	return false
end

function modifier_spirit_breaker_bulldoze_lua:IsDebuff()
	return false
end

function modifier_spirit_breaker_bulldoze_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spirit_breaker_bulldoze_lua:OnCreated( kv )
	-- references
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.resistance = self:GetAbility():GetSpecialValueFor( "status_resistance" )

	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Spirit_Breaker.Bulldoze.Cast"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_spirit_breaker_bulldoze_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spirit_breaker_bulldoze_lua:OnRemoved()
end

function modifier_spirit_breaker_bulldoze_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spirit_breaker_bulldoze_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
	}

	return funcs
end

function modifier_spirit_breaker_bulldoze_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_spirit_breaker_bulldoze_lua:GetModifierStatusResistance()
	return self.resistance
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spirit_breaker_bulldoze_lua:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf"
end

function modifier_spirit_breaker_bulldoze_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end