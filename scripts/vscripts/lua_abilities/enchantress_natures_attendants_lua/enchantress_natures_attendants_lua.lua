enchantress_natures_attendants_lua = class({})
LinkLuaModifier( "modifier_enchantress_natures_attendants_lua", "lua_abilities/enchantress_natures_attendants_lua/modifier_enchantress_natures_attendants_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function enchantress_natures_attendants_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetDuration()

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_enchantress_natures_attendants_lua", -- modifier name
		{ duration = duration } -- kv
	)
end