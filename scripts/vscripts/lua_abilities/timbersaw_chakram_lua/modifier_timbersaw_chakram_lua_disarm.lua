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
modifier_timbersaw_chakram_lua_disarm = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_chakram_lua_disarm:IsHidden()
	return false
end

function modifier_timbersaw_chakram_lua_disarm:IsDebuff()
	return false
end

function modifier_timbersaw_chakram_lua_disarm:IsPurgable()
	return false
end

function modifier_timbersaw_chakram_lua_disarm:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_chakram_lua_disarm:OnCreated( kv )
end

function modifier_timbersaw_chakram_lua_disarm:OnRefresh( kv )
end

function modifier_timbersaw_chakram_lua_disarm:OnRemoved()
end

function modifier_timbersaw_chakram_lua_disarm:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_timbersaw_chakram_lua_disarm:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end