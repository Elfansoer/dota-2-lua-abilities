bane_enfeeble_lua = class({})
LinkLuaModifier( "modifier_bane_enfeeble_lua", "lua_abilities/bane_enfeeble_lua/modifier_bane_enfeeble_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bane_enfeeble_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("enfeeble_tooltip_duration")

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- logic
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bane_enfeeble_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
function bane_enfeeble_lua:PlayEffects( target )
	-- Get Resources
	local sound_cast1 = "Hero_Bane.Enfeeble.Cast"
	local sound_cast2 = "Hero_Bane.Enfeeble"

	-- Create Sound
	EmitSoundOn( sound_cast1, self:GetCaster() )
	EmitSoundOn( sound_cast2, target )
end