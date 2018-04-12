modifier_sandra_will_to_live_threshold = class({})
local tempTable = require("util/tempTable")
--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_will_to_live_threshold:IsHidden()
	return true
end

function modifier_sandra_will_to_live_threshold:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_sandra_will_to_live_threshold:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_will_to_live_threshold:OnCreated( kv )
	if IsServer() then
		-- references
		self.modifier = tempTable:RetATValue( kv.modifier )
		self.stack = kv.stack
	end
end

function modifier_sandra_will_to_live_threshold:OnDestroy( kv )
	if IsServer() then
		-- references
		self.modifier:RemoveStack( self.stack )
	end
end