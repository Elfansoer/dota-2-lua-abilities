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
modifier_timbersaw_chakram_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_chakram_lua:IsHidden()
	return false
end

function modifier_timbersaw_chakram_lua:IsDebuff()
	return true
end

function modifier_timbersaw_chakram_lua:IsStunDebuff()
	return false
end

function modifier_timbersaw_chakram_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_chakram_lua:OnCreated( kv )
	-- references
	if not self:GetAbility():IsNull() then
		self.slow = self:GetAbility():GetSpecialValueFor( "slow" ) or 0
	else
		-- ability is deleted
		self.slow = 0
	end
	self.step = 5
end

function modifier_timbersaw_chakram_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_timbersaw_chakram_lua:OnRemoved()
end

function modifier_timbersaw_chakram_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_timbersaw_chakram_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_timbersaw_chakram_lua:GetModifierMoveSpeedBonus_Percentage()
	-- reduced to step of 5
	return -math.floor( (100-self:GetParent():GetHealthPercent())/self.step ) * self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_timbersaw_chakram_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost.vpcf"
end