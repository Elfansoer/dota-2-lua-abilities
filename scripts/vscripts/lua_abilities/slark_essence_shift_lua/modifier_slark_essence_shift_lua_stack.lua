modifier_slark_essence_shift_lua_stack = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_essence_shift_lua_stack:IsHidden()
	return true
end

function modifier_slark_essence_shift_lua_stack:IsPurgable()
	return false
end
function modifier_slark_essence_shift_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_essence_shift_lua_stack:OnCreated( kv )
	if IsServer() then
		self.modifier = tempTable:RetATValue( kv.modifier )
	end
end

function modifier_slark_essence_shift_lua_stack:OnRemoved()
	if IsServer() then
		self.modifier:RemoveStack()
	end
end