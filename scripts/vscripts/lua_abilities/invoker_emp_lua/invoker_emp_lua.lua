invoker_emp_lua = class({})
LinkLuaModifier( "modifier_invoker_emp_lua_thinker", "lua_abilities/invoker_emp_lua/modifier_invoker_emp_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function invoker_emp_lua:GetAOERadius()
	return self:GetSpecialValueFor( "area_of_effect" )
end

--------------------------------------------------------------------------------
-- Ability Start
function invoker_emp_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor("delay")

	-- create modifier thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_emp_lua_thinker", -- modifier name
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Play effects
	local sound_cast = "Hero_Invoker.EMP.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end