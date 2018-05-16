sona_hymn_of_valor = class({})

--------------------------------------------------------------------------------
-- Ability Start
function sona_hymn_of_valor:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("radius")
	local targets = self:GetSpecialValueFor("targets")

	-- precache projectile info
	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor("speed")
	local info = {
		-- Target = heroes[i],
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                           -- Optional
		bReplaceExisting = false,                         -- Optional
		bDrawsOnMinimap = false,                          -- Optional
	}

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- find priorities
	local heroes = {}
	local creeps = {}
	for i=1,#enemies do
		if enemies[i]:IsHero() then 
			table.insert(heroes,enemies[i])
		else
			table.insert(creeps,enemies[i])
		end
	end

	-- projectile
	local creep_number = targets - #heroes
	for i=1,math.min(targets,#heroes) do
		-- create projectile
		info.Target = heroes[i]
		ProjectileManager:CreateTrackingProjectile(info)
	end
	for i=1,math.max(0,creep_number) do
		info.Target = creeps[i]
		ProjectileManager:CreateTrackingProjectile(info)
	end

end
--------------------------------------------------------------------------------
-- Projectile
function sona_hymn_of_valor:OnProjectileHit( target, location )
	if target:IsInvulnerable() or target:IsMagicImmune() then return end

	-- damage
	local damage = self:GetSpecialValueFor("damage")
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------
function sona_hymn_of_valor:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end