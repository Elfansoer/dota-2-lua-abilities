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
modifier_muerta_dead_shot_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_dead_shot_lua_slow:IsHidden()
	return false
end

function modifier_muerta_dead_shot_lua_slow:IsDebuff()
	return true
end

function modifier_muerta_dead_shot_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_dead_shot_lua_slow:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "impact_slow_percent" )

	if not IsServer() then return end
end

function modifier_muerta_dead_shot_lua_slow:OnRefresh( kv )
	self.slow = self:GetAbility():GetSpecialValueFor( "impact_slow_percent" )
end

function modifier_muerta_dead_shot_lua_slow:OnRemoved()
end

function modifier_muerta_dead_shot_lua_slow:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_muerta_dead_shot_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_muerta_dead_shot_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_dead_shot_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_deadshot_debuff_slow.vpcf"
end

function modifier_muerta_dead_shot_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end