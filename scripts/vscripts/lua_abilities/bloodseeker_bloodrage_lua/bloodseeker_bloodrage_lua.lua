bloodseeker_bloodrage_lua = class({})
LinkLuaModifier( "modifier_bloodseeker_bloodrage_lua", "lua_abilities/bloodseeker_bloodrage_lua/modifier_bloodseeker_bloodrage_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bloodseeker_bloodrage_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bloodseeker_bloodrage_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	local sound_cast = "hero_bloodseeker.bloodRage"
	EmitSoundOn( sound_cast, caster )
end