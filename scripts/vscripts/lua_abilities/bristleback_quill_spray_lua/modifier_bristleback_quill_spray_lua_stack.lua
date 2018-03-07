modifier_bristleback_quill_spray_lua_stack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_quill_spray_lua_stack:IsHidden()
	return true
end

function modifier_bristleback_quill_spray_lua_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_bristleback_quill_spray_lua_stack:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_quill_spray_lua_stack:OnCreated( kv )
	if IsServer() then
		-- references
		self.parent = self:GetAbility():RetATValue( kv.modifier )
	end
end

function modifier_bristleback_quill_spray_lua_stack:OnRefresh( kv )
	
end

function modifier_bristleback_quill_spray_lua_stack:OnDestroy( kv )
	if IsServer() then
		self.parent:RemoveStack()
	end
end