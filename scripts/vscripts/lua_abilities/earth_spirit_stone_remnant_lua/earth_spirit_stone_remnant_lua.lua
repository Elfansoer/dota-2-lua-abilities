earth_spirit_stone_remnant_lua = class({})
LinkLuaModifier( "modifier_generic_charges", "lua_abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_earth_spirit_stone_remnant_lua", "lua_abilities/earth_spirit_stone_remnant_lua/modifier_earth_spirit_stone_remnant_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_earth_spirit_stone_remnant_lua_effect", "lua_abilities/earth_spirit_stone_remnant_lua/modifier_earth_spirit_stone_remnant_lua_effect", LUA_MODIFIER_MOTION_NONE )


--------------------------------------------------------------------------------
-- Passive Modifier
function earth_spirit_stone_remnant_lua:GetIntrinsicModifierName()
	return "modifier_generic_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_stone_remnant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- summon stone
	local stone = CreateUnitByName( "npc_dota_earth_spirit_stone", point, true, nil, nil, self:GetCaster():GetTeamNumber() )

	-- add effect modifier
	stone:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earth_spirit_stone_remnant_lua_effect", -- modifier name
		{  } -- kv
	)

	-- add stone remnant modifier
	stone:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earth_spirit_stone_remnant_lua", -- modifier name
		{ duration = duration } -- kv
	)
end

function earth_spirit_stone_remnant_lua:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end