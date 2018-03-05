bristleback_viscous_nasal_goo_lua = class({})
LinkLuaModifier( "modifier_bristleback_viscous_nasal_goo_lua", "lua_abilities/bristleback_viscous_nasal_goo_lua/modifier_bristleback_viscous_nasal_goo_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bristleback_viscous_nasal_goo_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()

	-- load data
	local projectile_name = "name"
	local projectile_speed = self:GetSpecialValueFor("some_value")

	-- Create Projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)

end

function bristleback_viscous_nasal_goo_lua:OnProjectileHit( hTarget, vLocation )
	local stack_duration = self:GetSpecialValueFor("some_value")

	-- Add modifier
	hTarget:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bristleback_viscous_nasal_goo_lua", -- modifier name
		{ duration = stack_duration } -- kv
	)
end