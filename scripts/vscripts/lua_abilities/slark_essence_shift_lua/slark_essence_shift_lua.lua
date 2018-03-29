slark_essence_shift_lua = class({})
LinkLuaModifier( "modifier_slark_essence_shift_lua", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_lua_debuff", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_lua_stack", "lua_abilities/slark_essence_shift_lua/modifier_slark_essence_shift_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_essence_shift_lua:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_lua"
end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function slark_essence_shift_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function slark_essence_shift_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function slark_essence_shift_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function slark_essence_shift_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end