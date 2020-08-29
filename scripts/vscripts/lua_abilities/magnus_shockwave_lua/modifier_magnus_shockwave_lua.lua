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
modifier_magnus_shockwave_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magnus_shockwave_lua:IsHidden()
	return false
end

function modifier_magnus_shockwave_lua:IsDebuff()
	return true
end

function modifier_magnus_shockwave_lua:IsStunDebuff()
	return false
end

function modifier_magnus_shockwave_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magnus_shockwave_lua:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow" )

	if not IsServer() then return end
end

function modifier_magnus_shockwave_lua:OnRefresh( kv )
	end

function modifier_magnus_shockwave_lua:OnRemoved()
end

function modifier_magnus_shockwave_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magnus_shockwave_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_magnus_shockwave_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_magnus_shockwave_lua:GetEffectName()
	return "particles/units/heroes/hero_magnataur/magnataur_skewer_debuff.vpcf"
end

function modifier_magnus_shockwave_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end