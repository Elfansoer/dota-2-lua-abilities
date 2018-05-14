riven_ki_burst = class({})
LinkLuaModifier( "modifier_riven_ki_burst", "custom_abilities/riven_ki_burst/modifier_riven_ki_burst", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function riven_ki_burst:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local delay = self:GetSpecialValueFor("delay")

	-- logic
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_riven_ki_burst", -- modifier name
		{ delay = delay } -- kv
	)

	-- dodge projectile
	ProjectileManager:ProjectileDodge( caster )

	-- effects
end