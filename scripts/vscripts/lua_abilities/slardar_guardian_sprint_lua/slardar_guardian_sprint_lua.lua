slardar_guardian_sprint_lua = class({})
LinkLuaModifier( "modifier_slardar_guardian_sprint_lua", "lua_abilities/slardar_guardian_sprint_lua/modifier_slardar_guardian_sprint_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function slardar_guardian_sprint_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local buff_duration = self:GetSpecialValueFor("duration")

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slardar_guardian_sprint_lua", -- modifier name
		{ duration = buff_duration } -- kv
	)

	self:PlayEffects()
end

--------------------------------------------------------------------------------
function slardar_guardian_sprint_lua:PlayEffects()
	-- Get Resources
	local sound_cast = "Hero_Slardar.Sprint"

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end