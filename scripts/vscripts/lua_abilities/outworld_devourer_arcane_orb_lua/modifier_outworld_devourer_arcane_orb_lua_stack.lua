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
modifier_outworld_devourer_arcane_orb_lua_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_outworld_devourer_arcane_orb_lua_stack:IsHidden()
	return true
end

function modifier_outworld_devourer_arcane_orb_lua_stack:IsPurgable()
	return false
end

function modifier_outworld_devourer_arcane_orb_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_outworld_devourer_arcane_orb_lua_stack:OnCreated( kv )
	if not IsServer() then return end
	self.stack = kv.stack
end

function modifier_outworld_devourer_arcane_orb_lua_stack:OnRemoved()
end

function modifier_outworld_devourer_arcane_orb_lua_stack:OnDestroy()
	if not IsServer() then return end

	if self.modifier then
		self.modifier:RemoveStack( self.stack )
	end
end