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
modifier_huskar_life_break_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_huskar_life_break_lua_debuff:IsHidden()
	return false
end

function modifier_huskar_life_break_lua_debuff:IsDebuff()
	return true
end

function modifier_huskar_life_break_lua_debuff:IsStunDebuff()
	return false
end

function modifier_huskar_life_break_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_huskar_life_break_lua_debuff:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "movespeed" )
end

function modifier_huskar_life_break_lua_debuff:OnRefresh( kv )
	
end

function modifier_huskar_life_break_lua_debuff:OnRemoved()
end

function modifier_huskar_life_break_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_huskar_life_break_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_huskar_life_break_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_huskar_life_break_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_huskar_lifebreak.vpcf"
end