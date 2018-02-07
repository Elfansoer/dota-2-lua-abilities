modifier_azura_multishot_crossbow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_azura_multishot_crossbow:IsHidden()
	return false
end

function modifier_azura_multishot_crossbow:IsDebuff()
	return false
end

function modifier_azura_multishot_crossbow:GetAttributes()
	-- return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
end

function modifier_azura_multishot_crossbow:IsPurgable()
	return false
end

function modifier_azura_multishot_crossbow:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_azura_multishot_crossbow:OnCreated( kv )
	-- references
	self.max_charge = self:GetAbility():GetSpecialValueFor( "max_charge" )
	self.bat_override = self:GetAbility():GetSpecialValueFor( "bat_override" )
	self.charge_restore = self:GetAbility():GetSpecialValueFor( "charge_restore" )

	-- set current stack
	self:SetStackCount(self.max_charge)

	-- set base attack time
	if IsServer() then
		self:GetParent():SetBaseAttackTime( self.bat_override )
	end
end

function modifier_azura_multishot_crossbow:OnRefresh( kv )
	-- references
	self.max_charge = self:GetAbility():GetSpecialValueFor( "max_charge" )
	self.bat_override = self:GetAbility():GetSpecialValueFor( "bat_override" )
	self.charge_restore = self:GetAbility():GetSpecialValueFor( "charge_restore" )

	-- calculate charge
	self:CalculateCharge()
end

function modifier_azura_multishot_crossbow:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_multishot_crossbow:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

function modifier_azura_multishot_crossbow:OnAttack( params )
	-- if IsServer() then
		-- filter
		local pass = false
		if params.attacker == self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			self:RemoveStack( 1 )
		end
	-- end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_azura_multishot_crossbow:CheckState()
	local state = {
	[MODIFIER_STATE_DISARMED] = (self:GetStackCount()==0),
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_azura_multishot_crossbow:OnIntervalThink()
	self:StartIntervalThink( -1 )
	self:AddStack( 1 )
end

--------------------------------------------------------------------------------
-- Helper Functions
function modifier_azura_multishot_crossbow:AddStack( value )
	local tab = ""
	if IsServer() then
		tab = "\t\t"
	end 
	print(tab,"----------------------------------------------------")
	print(tab,"current stack:", self:GetStackCount() )
	print(tab,"add stack:", value )
	self:SetStack( self:GetStackCount() + value )
end
function modifier_azura_multishot_crossbow:RemoveStack( value )
	local tab = ""
	if IsServer() then
		tab = "\t\t"
	end 
	print(tab,"----------------------------------------------------")
	print(tab,"current stack:", self:GetStackCount() )
	print(tab,"remove stack:", value )
	self:SetStack( self:GetStackCount() - value )
end

function modifier_azura_multishot_crossbow:SetStack( value )
	local tab = ""
	if IsServer() then
		tab = "\t\t"
	end 
	print(tab,"----------------------------------------------------")
	print(tab,"prev-stack",self:GetStackCount())
	print(tab,"next-stack",value)
	if value > self.max_charge then
		self:SetStackCount( self.max_charge )
	elseif value < 0 then
		self:SetStackCount( 0 )
	else
		self:SetStackCount( value )
	end
	print(tab,"final-stack",self:GetStackCount())

	self:CalculateCharge()
end

function modifier_azura_multishot_crossbow:CalculateCharge()
	if self:GetStackCount()==self.max_charge then
		-- stop duration
		self:SetDuration( 0, true )

		-- stop charging
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0 then
			-- start charging
			self:StartIntervalThink( self.charge_restore )
			self:SetDuration( self.charge_restore, true )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_azura_multishot_crossbow:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_azura_multishot_crossbow:GetEffectAttachType()
-- 	return PATTACH_XX
-- end
