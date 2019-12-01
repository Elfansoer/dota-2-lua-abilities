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
modifier_snapfire_scatterblast_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_snapfire_scatterblast_lua:IsHidden()
	return false
end

function modifier_snapfire_scatterblast_lua:IsDebuff()
	return true
end

function modifier_snapfire_scatterblast_lua:IsStunDebuff()
	return false
end

function modifier_snapfire_scatterblast_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_snapfire_scatterblast_lua:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow_pct" )
end

function modifier_snapfire_scatterblast_lua:OnRefresh( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow_pct" )	
end

function modifier_snapfire_scatterblast_lua:OnRemoved()
end

function modifier_snapfire_scatterblast_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_snapfire_scatterblast_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_snapfire_scatterblast_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_snapfire_scatterblast_lua:GetEffectName()
	return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_snapfire_scatterblast_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_snapfire_scatterblast_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_snapfire_scatterblast_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end