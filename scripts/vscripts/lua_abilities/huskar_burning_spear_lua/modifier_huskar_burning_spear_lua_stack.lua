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
modifier_huskar_burning_spear_lua_stack = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_huskar_burning_spear_lua_stack:IsHidden()
	return true
end

function modifier_huskar_burning_spear_lua_stack:IsPurgable()
	return false
end

function modifier_huskar_burning_spear_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_huskar_burning_spear_lua_stack:OnCreated( kv )
	if IsServer() then
		-- get references
		self.modifier = tempTable:RetATValue( kv.modifier )
	end

	-- play effects
	local sound_cast = "Hero_Huskar.Burning_Spear"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_huskar_burning_spear_lua_stack:OnRemoved()
	if IsServer() then
		-- decrement stack
		if not self.modifier:IsNull() then
			self.modifier:DecrementStackCount()
		end
	end
end

function modifier_huskar_burning_spear_lua_stack:OnDestroy()
end