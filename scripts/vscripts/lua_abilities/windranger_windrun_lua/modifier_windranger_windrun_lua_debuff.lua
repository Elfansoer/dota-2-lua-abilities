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
modifier_windranger_windrun_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_windranger_windrun_lua_debuff:IsHidden()
	return false
end

function modifier_windranger_windrun_lua_debuff:IsDebuff()
	return true
end

function modifier_windranger_windrun_lua_debuff:IsStunDebuff()
	return false
end

function modifier_windranger_windrun_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_windranger_windrun_lua_debuff:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "enemy_movespeed_bonus_pct" )
end

function modifier_windranger_windrun_lua_debuff:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "enemy_movespeed_bonus_pct" )
end

function modifier_windranger_windrun_lua_debuff:OnRemoved()
end

function modifier_windranger_windrun_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_windranger_windrun_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_windranger_windrun_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_windranger_windrun_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_windrunner/windrunner_windrun_slow.vpcf"
end

function modifier_windranger_windrun_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end