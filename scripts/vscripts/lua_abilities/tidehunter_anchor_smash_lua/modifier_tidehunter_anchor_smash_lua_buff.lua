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
modifier_tidehunter_anchor_smash_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tidehunter_anchor_smash_lua_buff:IsHidden()
	return true
end

function modifier_tidehunter_anchor_smash_lua_buff:IsDebuff()
	return false
end

function modifier_tidehunter_anchor_smash_lua_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tidehunter_anchor_smash_lua_buff:OnCreated( kv )
	if not IsServer() then return end
	self.bonus = kv.bonus
end

function modifier_tidehunter_anchor_smash_lua_buff:OnRefresh( kv )
end

function modifier_tidehunter_anchor_smash_lua_buff:OnRemoved()
end

function modifier_tidehunter_anchor_smash_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tidehunter_anchor_smash_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SUPPRESS_CLEAVE, -- doesn't work yet
	}

	return funcs
end

function modifier_tidehunter_anchor_smash_lua_buff:GetModifierPreAttack_BonusDamage()
	return self.bonus
end

function modifier_tidehunter_anchor_smash_lua_buff:GetSuppressCleave()
	return 1
end