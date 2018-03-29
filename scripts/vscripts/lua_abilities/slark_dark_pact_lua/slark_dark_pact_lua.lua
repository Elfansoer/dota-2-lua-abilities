slark_dark_pact_lua = class({})
LinkLuaModifier( "modifier_slark_dark_pact_lua", "lua_abilities/slark_dark_pact_lua/modifier_slark_dark_pact_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function slark_dark_pact_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slark_dark_pact_lua", -- modifier name
		{} -- kv
	)
end