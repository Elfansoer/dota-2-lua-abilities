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
modifier_muerta_the_calling_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_the_calling_lua_slow:IsHidden()
	return false
end

function modifier_muerta_the_calling_lua_slow:IsDebuff()
	return true
end

function modifier_muerta_the_calling_lua_slow:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_the_calling_lua_slow:OnCreated( kv )
	-- references
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "aura_movespeed_slow" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "aura_attackspeed_slow" )

	if not IsServer() then return end
end

function modifier_muerta_the_calling_lua_slow:OnRefresh( kv )
end

function modifier_muerta_the_calling_lua_slow:OnRemoved()
end

function modifier_muerta_the_calling_lua_slow:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_muerta_the_calling_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_muerta_the_calling_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_muerta_the_calling_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_the_calling_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf"
end

function modifier_muerta_the_calling_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end