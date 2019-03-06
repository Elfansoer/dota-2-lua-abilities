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
modifier_mars_gods_rebuke_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_gods_rebuke_lua:IsHidden()
	return true
end

function modifier_mars_gods_rebuke_lua:IsDebuff()
	return false
end

function modifier_mars_gods_rebuke_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_gods_rebuke_lua:OnCreated( kv )
	-- references
	self.bonus_damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_vs_heroes" )
	self.bonus_crit = self:GetAbility():GetSpecialValueFor( "crit_mult" )
end

function modifier_mars_gods_rebuke_lua:OnRefresh( kv )
end

function modifier_mars_gods_rebuke_lua:OnRemoved()
end

function modifier_mars_gods_rebuke_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mars_gods_rebuke_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}

	return funcs
end

function modifier_mars_gods_rebuke_lua:GetModifierPreAttack_BonusDamagePostCrit( params )
	if not IsServer() then return end
	return self.bonus_damage
end
function modifier_mars_gods_rebuke_lua:GetModifierPreAttack_CriticalStrike( params )
	return self.bonus_crit
end