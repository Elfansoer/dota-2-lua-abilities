modifier_invoker_quas_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_quas_lua:IsHidden()
	return false
end

function modifier_invoker_quas_lua:IsDebuff()
	return false
end

function modifier_invoker_quas_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_quas_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_quas_lua:OnCreated( kv )
	-- references
	self.regen = self:GetAbility():GetSpecialValueFor( "health_regen_per_instance" ) -- special value
end

function modifier_invoker_quas_lua:OnRefresh( kv )
	-- references
	self.regen = self:GetAbility():GetSpecialValueFor( "health_regen_per_instance" ) -- special value	
end

function modifier_invoker_quas_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_quas_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end
function modifier_invoker_quas_lua:GetModifierConstantHealthRegen()
	return self.regen
end