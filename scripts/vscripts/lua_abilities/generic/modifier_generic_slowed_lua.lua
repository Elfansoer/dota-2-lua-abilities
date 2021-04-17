--------------------------------------------------------------------------------
modifier_generic_slowed_lua = class({})
--[[
KV (default):
	isPurgable (1)
	interval (1)
	duration (0)
	as_slow (0), flat, positive means slower
	ms_slow (0), percentage, positive means slower
	dps (0), damage per second, not per interval
]]

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_slowed_lua:IsHidden()
	return false
end

function modifier_generic_slowed_lua:IsDebuff()
	return true
end

function modifier_generic_slowed_lua:IsPurgable()
	return self.isPurgable
end

-- Optional Classifications
function modifier_generic_slowed_lua:IsStunDebuff()
	return false
end

function modifier_generic_slowed_lua:RemoveOnDeath()
	return true
end

function modifier_generic_slowed_lua:DestroyOnExpire()
	return true
end

function modifier_generic_slowed_lua:AllowIllusionDuplicate()
	return false
end

function modifier_generic_slowed_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_slowed_lua:OnCreated( kv )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- get data
	self.as_slow = kv.as_slow or 0
	self.ms_slow = kv.ms_slow or 0
	self.interval = kv.interval or 1
	self.dps = kv.dps or 0
	self.isPurgable = kv.isPurgable==1

	-- calculate status resistance
	local resist = 1-self:GetParent():GetStatusResistance()

	-- set slow value
	self.as_slow = self.as_slow*resist
	self.ms_slow = self.ms_slow*resist

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_generic_slowed_lua:OnRefresh( kv )
	
end

function modifier_generic_slowed_lua:OnRemoved()
end

function modifier_generic_slowed_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_generic_slowed_lua:AddCustomTransmitterData()
	-- on server
	local data = {
		as_slow = self.as_slow,
		ms_slow = self.ms_slow,
	}

	return data
end

function modifier_generic_slowed_lua:HandleCustomTransmitterData( data )
	-- on client
	self.as_slow = data.as_slow
	self.ms_slow = data.ms_slow
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_slowed_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_generic_slowed_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_generic_slowed_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end