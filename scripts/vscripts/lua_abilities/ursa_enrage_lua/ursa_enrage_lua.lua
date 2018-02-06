ursa_enrage_lua = class({})
LinkLuaModifier( "modifier_ursa_enrage_lua", "lua_abilities/ursa_enrage_lua/modifier_ursa_enrage_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function ursa_enrage_lua:OnSpellStart()
	-- get references
	local bonus_duration = self:GetSpecialValueFor("duration")

	-- Add buff modifier
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_ursa_enrage_lua",
		{ duration = bonus_duration }
	)
end
