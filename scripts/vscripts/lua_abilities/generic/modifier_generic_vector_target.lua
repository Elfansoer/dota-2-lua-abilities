-- Created by Elfansoer
--[[
	HOW TO USE:
	- Set the ability to create this permanent modifier
	- use ability:CursorCastTarget or CursorCastPosition for primary cast
	- use ability.vector_position for secondary cast
]]

--------------------------------------------------------------------------------
modifier_generic_vector_target = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_vector_target:IsHidden()
	return true
end

function modifier_generic_vector_target:IsPurgable()
	return false
end

function modifier_generic_vector_target:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_vector_target:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_generic_vector_target:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if params.order_type==DOTA_UNIT_ORDER_VECTOR_TARGET_POSITION then
		self:GetAbility().vector_position = params.new_pos
	end
end