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
modifier_alchemist_greevils_greed_lua_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_alchemist_greevils_greed_lua_stack:IsHidden()
	return true
end

function modifier_alchemist_greevils_greed_lua_stack:IsPurgable()
	return false
end

function modifier_alchemist_greevils_greed_lua_stack:RemoveOnDeath()
	return false
end

function modifier_alchemist_greevils_greed_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_alchemist_greevils_greed_lua_stack:OnCreated( kv )
end

function modifier_alchemist_greevils_greed_lua_stack:OnRefresh( kv )
	
end

function modifier_alchemist_greevils_greed_lua_stack:OnRemoved()
end

function modifier_alchemist_greevils_greed_lua_stack:OnDestroy()
	if not IsServer() then return end
	self.parent_modifier:RemoveStack()
end