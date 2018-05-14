riven_blade_of_the_exile = class({})
LinkLuaModifier( "modifier_riven_blade_of_the_exile", "custom_abilities/riven_blade_of_the_exile/modifier_riven_blade_of_the_exile", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function riven_blade_of_the_exile:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- logic
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_riven_blade_of_the_exile", -- modifier name
		{ duration = duration } -- kv
	)
end