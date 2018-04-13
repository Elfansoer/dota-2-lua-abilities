modifier_tinker_laser_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_laser_lua:IsHidden()
	return false
end

function modifier_tinker_laser_lua:IsDebuff()
	return true
end

function modifier_tinker_laser_lua:IsStunDebuff()
	return false
end

function modifier_tinker_laser_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_laser_lua:OnCreated( kv )
	-- references
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_lua:OnRefresh( kv )
	-- references
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_laser_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}

	return funcs
end

function modifier_tinker_laser_lua:GetModifierMiss_Percentage()
	return self.miss_rate
end