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
modifier_muerta_pierce_the_veil_lua_undisarm = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_pierce_the_veil_lua_undisarm:IsHidden()
	return true
end

function modifier_muerta_pierce_the_veil_lua_undisarm:IsDebuff()
	return false
end

function modifier_muerta_pierce_the_veil_lua_undisarm:IsPurgable()
	return false
end

function modifier_muerta_pierce_the_veil_lua_undisarm:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_pierce_the_veil_lua_undisarm:OnCreated( kv )
	if not IsServer() then return end
end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnRefresh( kv )
end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnRemoved()
end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_muerta_pierce_the_veil_lua_undisarm:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = false,
	}

	return state
end