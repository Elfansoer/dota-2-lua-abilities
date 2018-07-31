lifestealer_open_wounds_lua = class({})
LinkLuaModifier( "modifier_lifestealer_open_wounds_lua", "lua_abilities/lifestealer_open_wounds_lua/modifier_lifestealer_open_wounds_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lifestealer_open_wounds_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- apply modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lifestealer_open_wounds_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_LifeStealer.OpenWounds.Cast"
	local sound_target = "Hero_LifeStealer.OpenWounds"
	EmitSoundOn( sound_cast, caster )
	EmitSoundOn( sound_target, target )
end