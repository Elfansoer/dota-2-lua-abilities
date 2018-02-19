slark_dark_pact_lua = class({})
LinkLuaModifier( "modifier_slark_dark_pact_lua", "lua_abilities/slark_dark_pact_lua/modifier_slark_dark_pact_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function slark_dark_pact_lua:OnSpellStart()
	-- Add timer
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_slark_dark_pact_lua",
		{}
	)
end