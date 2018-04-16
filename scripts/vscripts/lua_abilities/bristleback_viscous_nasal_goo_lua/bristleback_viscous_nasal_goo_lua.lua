bristleback_viscous_nasal_goo_lua = class({})
LinkLuaModifier( "modifier_bristleback_viscous_nasal_goo_lua", "lua_abilities/bristleback_viscous_nasal_goo_lua/modifier_bristleback_viscous_nasal_goo_lua", LUA_MODIFIER_MOTION_NONE )

function bristleback_viscous_nasal_goo_lua:GetBehavior()
	local behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
	if self:GetCaster():HasScepter() then
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
	end
	return behavior
end

--------------------------------------------------------------------------------
-- Ability Start
function bristleback_viscous_nasal_goo_lua:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()

	-- load data
	local projectile_name = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf"
	local projectile_speed = self:GetSpecialValueFor("goo_speed")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
	}
	if self:GetCaster():HasScepter() then
		-- Find Units in Radius
		local radius = self:GetSpecialValueFor("radius_scepter")
		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			self:GetCaster():GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		for _,enemy in pairs(enemies) do
			info.Target = enemy
			ProjectileManager:CreateTrackingProjectile(info)
		end
	else
		info.Target = target
		-- Create Projectile
		ProjectileManager:CreateTrackingProjectile(info)
	end

	self:PlayEffects1()
end

function bristleback_viscous_nasal_goo_lua:OnProjectileHit( hTarget, vLocation )
	-- cancel if got linken
	if hTarget == nil or hTarget:IsInvulnerable() then
		return
	end

	if not self:GetCaster():HasScepter() then
		if hTarget:TriggerSpellAbsorb( self ) then
			return
		end
	end

	local stack_duration = self:GetSpecialValueFor("goo_duration")

	-- Add modifier
	hTarget:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bristleback_viscous_nasal_goo_lua", -- modifier name
		{ duration = stack_duration } -- kv
	)

	self:PlayEffects2( hTarget )
end

function bristleback_viscous_nasal_goo_lua:PlayEffects1()
	local sound_cast = "Hero_Bristleback.ViscousGoo.Cast"

	EmitSoundOn( sound_cast, self:GetCaster() )
end

function bristleback_viscous_nasal_goo_lua:PlayEffects2( target )
	local sound_cast = "Hero_Bristleback.ViscousGoo.Target"

	EmitSoundOn( sound_cast, target )
end
