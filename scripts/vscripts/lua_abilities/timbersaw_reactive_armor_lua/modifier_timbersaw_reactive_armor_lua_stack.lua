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
modifier_timbersaw_reactive_armor_lua_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_reactive_armor_lua_stack:IsHidden()
	return true
end

function modifier_timbersaw_reactive_armor_lua_stack:IsPurgable()
	return false
end

function modifier_timbersaw_reactive_armor_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_reactive_armor_lua_stack:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveStack()
end