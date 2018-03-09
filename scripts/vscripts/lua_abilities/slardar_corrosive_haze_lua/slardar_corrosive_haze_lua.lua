slardar_corrosive_haze_lua = class({})
LinkLuaModifier( "modifier_slardar_corrosive_haze_lua", "lua_abilities/slardar_corrosive_haze_lua/modifier_slardar_corrosive_haze_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function slardar_corrosive_haze_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- cancel if blocked
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- load data
	local debuff_duration = self:GetSpecialValueFor("duration")

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slardar_corrosive_haze_lua", -- modifier name
		{ duration = debuff_duration } -- kv
	)

	-- Play sounds
	EmitSoundOn( "Hero_Slardar.Amplify_Damage", target )
end