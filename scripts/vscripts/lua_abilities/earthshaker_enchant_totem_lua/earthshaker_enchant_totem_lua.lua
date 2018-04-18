earthshaker_enchant_totem_lua = class({})
LinkLuaModifier( "modifier_earthshaker_enchant_totem_lua", "lua_abilities/earthshaker_enchant_totem_lua/modifier_earthshaker_enchant_totem_lua", LUA_MODIFIER_MOTION_NONE )
-- LinkLuaModifier( "modifier_earthshaker_enchant_totem_lua_movement", "lua_abilities/earthshaker_enchant_totem_lua/modifier_earthshaker_enchant_totem_lua_movement", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function earthshaker_enchant_totem_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	-- local target = self:GetCursorTarget()
	-- local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earthshaker_enchant_totem_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	local sound_cast = "Hero_EarthShaker.Totem"
	EmitSoundOn( sound_cast, caster )
end