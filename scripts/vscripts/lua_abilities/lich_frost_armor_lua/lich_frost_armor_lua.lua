lich_frost_armor_lua = class({})
LinkLuaModifier( "modifier_lich_frost_armor_lua", "lua_abilities/lich_frost_armor_lua/modifier_lich_frost_armor_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_frost_armor_lua_buff", "lua_abilities/lich_frost_armor_lua/modifier_lich_frost_armor_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lich_frost_armor_lua_debuff", "lua_abilities/lich_frost_armor_lua/modifier_lich_frost_armor_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function lich_frost_armor_lua:GetIntrinsicModifierName()
	return "modifier_lich_frost_armor_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function lich_frost_armor_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lich_frost_armor_lua_buff", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	local sound_cast = "Hero_Lich.FrostArmor"
	EmitSoundOn( sound_cast, self:GetCaster() )
end