lifestealer_rage_lua = class({})
LinkLuaModifier( "modifier_lifestealer_rage_lua", "lua_abilities/lifestealer_rage_lua/modifier_lifestealer_rage_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lifestealer_rage_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- dispel
	caster:Purge( false, true, false, false, false )

	-- apply modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lifestealer_rage_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_LifeStealer.Rage"
	EmitSoundOn( sound_cast, caster )
end