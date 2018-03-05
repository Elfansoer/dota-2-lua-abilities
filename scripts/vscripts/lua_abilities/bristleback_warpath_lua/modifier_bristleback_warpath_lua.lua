modifier_bristleback_warpath_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bristleback_warpath_lua:IsHidden()
	return ( self:GetStackCount() == 0 )
end

function modifier_bristleback_warpath_lua:IsDebuff()
	return false
end

function modifier_bristleback_warpath_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bristleback_warpath_lua:OnCreated( kv )
	self.stack_max = self:GetAbility():GetSpecialValueFor("stack_max")
	self.stack_damage = self:GetAbility():GetSpecialValueFor("stack_damage")
	self.stack_movespeed = self:GetAbility():GetSpecialValueFor("stack_movespeed")

	if IsServer() then
		-- get AT value
		local at = self:GetAbility():AddATValue( self )

		-- Add stack
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_bristleback_warpath_lua_stack",
			{
				duration = kv.stack_duration,
				modifier = at,
			}
		)
	end

	-- set stack
	self:SetStackCount( 1 )
end

function modifier_bristleback_warpath_lua:OnRefresh( kv )
	self.stack_max = self:GetAbility():GetSpecialValueFor("stack_max")
	self.stack_damage = self:GetAbility():GetSpecialValueFor("stack_damage")
	self.stack_movespeed = self:GetAbility():GetSpecialValueFor("stack_movespeed")

	if IsServer() then
		-- get AT value
		local at = self:GetAbility():AddATValue( self )

		-- Add stack
		self:GetParent():AddNewModifier(
			self:GetCaster(),
			self:GetAbility(),
			"modifier_bristleback_warpath_lua_stack",
			{
				duration = kv.stack_duration,
				modifier = at,
			}
		)
	end

	-- increment stack
	self:IncrementStackCount()
end

function modifier_bristleback_warpath_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bristleback_warpath_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs
end
function modifier_bristleback_warpath_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.stack_movespeed * self:GetStackCount()
end
function modifier_bristleback_warpath_lua:GetModifierPreAttack_BonusDamage()
	return self.stack_damage * self:GetStackCount()
end
function modifier_bristleback_warpath_lua:OnAbilityExecuted( params )
	if IsServer() then
		-- filter
		local pass = false
		if params.unit==self:GetParent() then
			pass==true
		end

		-- logic
		if pass then
			-- check item ability
			local hAbility = params.ability
			if hAbility ~= nil and ( not hAbility:IsItem() ) and ( not hAbility:IsToggle() ) then
				if self:GetStackCount()<self.stack_max then
					self:IncrementStackCount()
				end
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Helper
function modifier_bristleback_warpath_lua:RemoveStack( kv )
	self:DecrementStackCount()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_bristleback_warpath_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_bristleback_warpath_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end