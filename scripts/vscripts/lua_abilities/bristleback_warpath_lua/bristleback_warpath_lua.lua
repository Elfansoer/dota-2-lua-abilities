bristleback_warpath_lua = class({})
LinkLuaModifier( "modifier_bristleback_warpath_lua", "lua_abilities/bristleback_warpath_lua/modifier_bristleback_warpath_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bristleback_warpath_lua_stack", "lua_abilities/bristleback_warpath_lua/modifier_bristleback_warpath_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function bristleback_warpath_lua:GetIntrinsicModifierName()
	return "modifier_bristleback_warpath_lua"
end

--------------------------------------------------------------------------------
-- Helper
function bristleback_warpath_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function bristleback_warpath_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function bristleback_warpath_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function bristleback_warpath_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end