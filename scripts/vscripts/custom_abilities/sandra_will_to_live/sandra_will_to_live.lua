sandra_will_to_live = class({})
LinkLuaModifier( "modifier_sandra_will_to_live", "custom_abilities/sandra_will_to_live/modifier_sandra_will_to_live", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sandra_will_to_live_delay", "custom_abilities/sandra_will_to_live/modifier_sandra_will_to_live_delay", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sandra_will_to_live_threshold", "custom_abilities/sandra_will_to_live/modifier_sandra_will_to_live_threshold", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sandra_will_to_live:GetIntrinsicModifierName()
	return "modifier_sandra_will_to_live"
end

-- Helper: AT table
function sandra_will_to_live:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function sandra_will_to_live:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function sandra_will_to_live:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function sandra_will_to_live:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end