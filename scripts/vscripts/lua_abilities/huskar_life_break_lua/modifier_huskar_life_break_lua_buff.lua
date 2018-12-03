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
modifier_huskar_life_break_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_huskar_life_break_lua_buff:IsHidden()
	return true
end

function modifier_huskar_life_break_lua_buff:IsDebuff()
	return false
end

function modifier_huskar_life_break_lua_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_huskar_life_break_lua_buff:OnCreated( kv )
end

function modifier_huskar_life_break_lua_buff:OnRefresh( kv )
end

function modifier_huskar_life_break_lua_buff:OnRemoved()
end

function modifier_huskar_life_break_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_huskar_life_break_lua_buff:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
-- 		MODIFIER_EVENT_ON_ATTACKED,
-- 	}

-- 	return funcs
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_huskar_life_break_lua_buff:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end