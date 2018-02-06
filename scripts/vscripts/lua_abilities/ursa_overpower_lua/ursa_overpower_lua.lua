ursa_overpower_lua = class({})
LinkLuaModifier( "modifier_ursa_overpower_lua", "lua_abilities/ursa_overpower_lua/modifier_ursa_overpower_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ursa_overpower_lua:OnSpellStart()
	-- get references
	local bonus_duration = self:GetDuration()

	-- Add buff modifier
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_ursa_overpower_lua",
		{ duration = bonus_duration }
	)

	-- Play effects
	self:PlayEffects()
end

function ursa_overpower_lua:PlayEffects()
	-- get resources
	local sound_cast = "Hero_Ursa.Overpower"

	-- play particles

	-- play sounds
	EmitSoundOn(sound_cast, self:GetCaster())
end