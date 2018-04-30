bloodseeker_blood_rite_lua = class({})
LinkLuaModifier( "modifier_generic_silenced_lua", "lua_abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bloodseeker_blood_rite_lua_thinker", "lua_abilities/bloodseeker_blood_rite_lua/modifier_bloodseeker_blood_rite_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function bloodseeker_blood_rite_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function bloodseeker_blood_rite_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_bloodseeker_blood_rite_lua_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)

	-- effects
	local sound_cast = "Hero_Bloodseeker.BloodRite.Cast"
	EmitSoundOn( sound_cast, caster )
end