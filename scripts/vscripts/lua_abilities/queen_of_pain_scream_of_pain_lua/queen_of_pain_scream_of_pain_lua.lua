queen_of_pain_scream_of_pain_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function queen_of_pain_scream_of_pain_lua:OnSpellStart()
	-- unit identifier
	self.caster = self:GetCaster()
	local point = self:GetCaster():GetOrigin()

	-- load data
	local radius = self:GetSpecialValueFor("area_of_effect")
	self.screamDamage = self:GetAbilityDamage()

	local projectile_name = "particles/units/heroes/hero_queenofpain/queen_scream_of_pain.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- Prebuilt Projectile info
	local info = {
		-- Target = target,
		Source = caster,
		Ability = self,	
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		vSourceLoc= point,                -- Optional (HOW)
		bDodgeable = false,                                -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bReplaceExisting = false,                         -- Optional
		bProvidesVision = false,                           -- Optional
	}

	-- create projectile to all enemies hit
	for _,enemy in pairs(enemies) do
		info.Target = enemy
		ProjectileManager:CreateTrackingProjectile(info)
	end

	-- Play effects
	self:PlayEffects( point )
end
--------------------------------------------------------------------------------
-- Projectile
function queen_of_pain_scream_of_pain_lua:OnProjectileHit( target, location )
	-- Apply Damage	 
	local damageTable = {
		victim = target,
		attacker = self.caster,
		damage = self.screamDamage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end
--------------------------------------------------------------------------------
-- Ability Considerations
function queen_of_pain_scream_of_pain_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
function queen_of_pain_scream_of_pain_lua:PlayEffects( location )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_queenofpain/queen_scream_of_pain_owner.vpcf"
	local sound_cast = "Hero_QueenOfPain.ScreamOfPain"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end