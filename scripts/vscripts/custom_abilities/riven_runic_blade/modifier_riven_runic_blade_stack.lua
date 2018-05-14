modifier_riven_runic_blade_stack = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_riven_runic_blade_stack:IsHidden()
	return true
end

function modifier_riven_runic_blade_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_riven_runic_blade_stack:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_riven_runic_blade_stack:OnCreated( kv )
	if IsServer() then
		self.parent = tempTable:RetATValue( kv.parent )
	end
end

function modifier_riven_runic_blade_stack:OnRemoved()
	if IsServer() then
		self.parent:RemoveStack()
	end
end