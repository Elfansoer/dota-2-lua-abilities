lion_hex_lua = class({})
LinkLuaModifier( "modifier_lion_hex_lua", "lua_abilities/lion_hex_lua/modifier_lion_hex_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lion_hex_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lion_hex_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	local sound_cast = "Hero_Lion.Voodoo"
	EmitSoundOn( sound_cast, caster )
end