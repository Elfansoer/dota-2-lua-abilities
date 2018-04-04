modifier_sniper_shrapnel_lua_charges = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_shrapnel_lua_charges:IsHidden()
	return false
end

function modifier_sniper_shrapnel_lua_charges:IsDebuff()
	return false
end

function modifier_sniper_shrapnel_lua_charges:IsPurgable()
	return false
end

function modifier_sniper_shrapnel_lua_charges:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_shrapnel_lua_charges:OnCreated( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:SetStackCount( self.max_charges )
		self:CalculateCharge()
	end
end

function modifier_sniper_shrapnel_lua_charges:OnRefresh( kv )
	-- references
	self.max_charges = self:GetAbility():GetSpecialValueFor( "max_charges" ) -- special value

	if IsServer() then
		self:CalculateCharge()
	end
end

function modifier_sniper_shrapnel_lua_charges:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_shrapnel_lua_charges:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_sniper_shrapnel_lua_charges:OnAbilityFullyCast( params )
	if IsServer() then
		if params.unit~=self:GetParent() or params.ability~=self:GetAbility() then
			return
		end

		self:DecrementStackCount()
		self:CalculateCharge()
	end
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sniper_shrapnel_lua_charges:OnIntervalThink()
	self:IncrementStackCount()
	self:StartIntervalThink(-1)
	self:CalculateCharge()
end

function modifier_sniper_shrapnel_lua_charges:CalculateCharge()
	self:GetAbility():EndCooldown()
	if self:GetStackCount()>=self.max_charges then
		-- stop charging
		self:SetDuration( -1, false )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			-- start charging
			local charge_time = self:GetAbility():GetCooldown( -1 )
			self:StartIntervalThink( charge_time )
			self:SetDuration( charge_time, true )
		end

		-- set on cooldown if no charges
		if self:GetStackCount()==0 then
			self:GetAbility():StartCooldown( self:GetRemainingTime() )
		end
	end
end