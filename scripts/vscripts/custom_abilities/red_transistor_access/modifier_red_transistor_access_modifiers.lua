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
modifier_red_transistor_access_modifiers = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_access_modifiers:IsHidden()
	return false
end

function modifier_red_transistor_access_modifiers:IsDebuff()
	return false
end

function modifier_red_transistor_access_modifiers:IsPurgable()
	return false
end

function modifier_red_transistor_access_modifiers:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_red_transistor_access_modifiers:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_access_modifiers:OnCreated( kv )
	if not IsServer() then return end
end

function modifier_red_transistor_access_modifiers:OnRefresh( kv )
	
end

function modifier_red_transistor_access_modifiers:OnRemoved()
end

function modifier_red_transistor_access_modifiers:OnDestroy()
end