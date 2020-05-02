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
modifier_jakiro_dual_breath_lua_ice = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_dual_breath_lua_ice:IsHidden()
	return false
end

function modifier_jakiro_dual_breath_lua_ice:IsDebuff()
	return true
end

function modifier_jakiro_dual_breath_lua_ice:IsStunDebuff()
	return false
end

function modifier_jakiro_dual_breath_lua_ice:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_dual_breath_lua_ice:OnCreated( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed_pct" )
end

function modifier_jakiro_dual_breath_lua_ice:OnRefresh( kv )
	-- references
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_pct" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed_pct" )	
end

function modifier_jakiro_dual_breath_lua_ice:OnRemoved()
end

function modifier_jakiro_dual_breath_lua_ice:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_jakiro_dual_breath_lua_ice:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_jakiro_dual_breath_lua_ice:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_jakiro_dual_breath_lua_ice:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_dual_breath_lua_ice:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_jakiro_dual_breath_lua_ice:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end