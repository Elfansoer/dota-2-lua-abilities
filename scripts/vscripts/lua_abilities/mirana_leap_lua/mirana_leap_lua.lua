mirana_leap_lua = class({})
LinkLuaModifier( "modifier_mirana_leap_lua", "lua_abilities/mirana_leap_lua/modifier_mirana_leap_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mirana_leap_lua_movement", "lua_abilities/mirana_leap_lua/modifier_mirana_leap_lua_movement", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Ability Start
function mirana_leap_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- references
	local bDuration = self:GetSpecialValueFor( "leap_bonus_duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_mirana_leap_lua", -- modifier name
		{ duration = bDuration } -- kv
	)

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_mirana_leap_lua_movement", -- modifier name
		{} -- kv
	)

	-- effects
	local sound_cast = "Ability.Leap"
	EmitSoundOn( sound_cast, caster )
end