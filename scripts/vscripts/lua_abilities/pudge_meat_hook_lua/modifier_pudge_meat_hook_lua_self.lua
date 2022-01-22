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
modifier_pudge_meat_hook_lua_self = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_meat_hook_lua_self:IsHidden()
	return true
end

function modifier_pudge_meat_hook_lua_self:IsDebuff()
	return false
end

function modifier_pudge_meat_hook_lua_self:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_pudge_meat_hook_lua_self:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end