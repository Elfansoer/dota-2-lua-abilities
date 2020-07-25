mirana_leap_lua = class({})
LinkLuaModifier( "modifier_mirana_leap_lua", "lua_abilities/mirana_leap_lua/modifier_mirana_leap_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_charges", "lua_abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Passive modifier
function mirana_leap_lua:GetIntrinsicModifierName()
	return "modifier_generic_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function mirana_leap_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- references
	local bDuration = self:GetSpecialValueFor( "leap_bonus_duration" )
	local distance = self:GetSpecialValueFor( "leap_distance" ) -- special value
	local speed = self:GetSpecialValueFor( "leap_speed" ) -- special value
	local height = 150

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_mirana_leap_lua", -- modifier name
		{ duration = bDuration } -- kv
	)

	-- leap
	local arc = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			distance = distance,
			speed = speed,
			height = height,
			fix_end = false,
			isForward = true,
		} -- kv
	)
	arc:SetEndCallback( function()
		-- enable when arc ends
		self:SetActivated( true )
	end)

	-- disable
	self:SetActivated( false )

	-- effects
	local sound_cast = "Ability.Leap"
	EmitSoundOn( sound_cast, caster )
end