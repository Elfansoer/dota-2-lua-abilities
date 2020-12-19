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
modifier_hoodwink_acorn_shot_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_acorn_shot_lua:IsHidden()
	return true
end

function modifier_hoodwink_acorn_shot_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_acorn_shot_lua:OnCreated( kv )
	-- references

	if not IsServer() then return end
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
end

function modifier_hoodwink_acorn_shot_lua:OnRefresh( kv )
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )	
end

function modifier_hoodwink_acorn_shot_lua:OnRemoved()
end

function modifier_hoodwink_acorn_shot_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hoodwink_acorn_shot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_hoodwink_acorn_shot_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus
end

function modifier_hoodwink_acorn_shot_lua:GetModifierProcAttack_Feedback( params )
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_DAMAGE,
		params.target,
		params.damage,
		self:GetCaster():GetPlayerOwner()
	)
end