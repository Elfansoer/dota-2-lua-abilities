modifier_slark_essence_shift_lua_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_essence_shift_lua_debuff:IsHidden()
	return false
end

function modifier_slark_essence_shift_lua_debuff:IsDebuff()
	return true
end

function modifier_slark_essence_shift_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_essence_shift_lua_debuff:OnCreated( kv )
	-- references
	self.stat_loss = self:GetAbility():GetSpecialValueFor( "stat_loss" )
	self.duration = kv.stack_duration

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_debuff:OnRefresh( kv )
	-- references
	self.stat_loss = self:GetAbility():GetSpecialValueFor( "stat_loss" )
	self.duration = kv.stack_duration

	if IsServer() then
		self:AddStack( self.duration )
	end
end

function modifier_slark_essence_shift_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slark_essence_shift_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end

function modifier_slark_essence_shift_lua_debuff:GetModifierBonusStats_Strength()
	return self:GetStackCount() * -self.stat_loss
end
function modifier_slark_essence_shift_lua_debuff:GetModifierBonusStats_Agility()
	return self:GetStackCount() * -self.stat_loss
end
function modifier_slark_essence_shift_lua_debuff:GetModifierBonusStats_Intellect()
	return self:GetStackCount() * -self.stat_loss
end

--------------------------------------------------------------------------------
-- Helper
function modifier_slark_essence_shift_lua_debuff:AddStack( duration )
	-- Add modifier
	local mod = self:GetParent():AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_slark_essence_shift_lua_stack",
		{
			duration = self.duration,
		}
	)
	mod.modifier = self

	-- Add stack
	self:IncrementStackCount()
end

function modifier_slark_essence_shift_lua_debuff:RemoveStack()
	self:DecrementStackCount()

	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end