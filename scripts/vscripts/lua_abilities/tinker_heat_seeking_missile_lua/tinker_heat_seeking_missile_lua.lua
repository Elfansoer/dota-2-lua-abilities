tinker_heat_seeking_missile_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function tinker_heat_seeking_missile_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")	
	local targets = self:GetSpecialValueFor("targets")
	if caster:HasScepter() then
		targets = self:GetSpecialValueFor("targets_scepter")
	end
	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor("speed")

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- create projectile for each enemy
	local info = {
		Source = caster,
		-- Target = target,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
		ExtraData = {
			damage = damage,
		}
	}
	for i=1,math.min(targets,#enemies) do
		info.Target = enemies[i]
		ProjectileManager:CreateTrackingProjectile( info )
	end

	-- effects
	local sound_cast = "Hero_Tinker.MissileAnim"
	EmitSoundOn( sound_cast, caster )
	if #enemies<1 then
		sound_cast = "Hero_Tinker.MissileAnim"
		EmitSoundOn( sound_cast, caster )
	end
end
--------------------------------------------------------------------------------
-- Projectile
function tinker_heat_seeking_missile_lua:OnProjectileHit_ExtraData( target, location, extraData )
	-- Apply damage
	local damage = {
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	ApplyDamage( damage )

	-- effects
	local sound_cast = "Hero_Tinker.Heat-Seeking_Missile.Impact"
	EmitSoundOn( sound_cast, target )
end