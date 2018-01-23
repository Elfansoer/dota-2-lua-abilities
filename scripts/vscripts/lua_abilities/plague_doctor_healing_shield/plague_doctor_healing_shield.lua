plague_doctor_healing_shield = class({})
LinkLuaModifier( "modifier_plague_doctor_healing_shield", "lua_abilities/plague_doctor_healing_shield/modifier_plague_doctor_healing_shield", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_plague_doctor_healing_shield_stack", "lua_abilities/plague_doctor_healing_shield/modifier_plague_doctor_healing_shield_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function plague_doctor_healing_shield:GetIntrinsicModifierName()
	return "modifier_plague_doctor_healing_shield"
end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function plague_doctor_healing_shield:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function plague_doctor_healing_shield:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function plague_doctor_healing_shield:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function plague_doctor_healing_shield:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end
