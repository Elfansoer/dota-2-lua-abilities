queen_of_pain_sonic_wave_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function queen_of_pain_sonic_wave_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/units/heroes/hero_queenofpain/queen_sonic_wave.vpcf"
	local projectile_distance = self:GetSpecialValueFor("distance")
	local projectile_speed = self:GetSpecialValueFor("speed")
	local projectile_start_radius = self:GetSpecialValueFor("starting_aoe")
	local projectile_end_radius = self:GetSpecialValueFor("final_aoe")
	local projectile_direction = (point-caster:GetOrigin()):Normalized()

	local info = {
    	Source = caster,
		Ability = self,
    	vSpawnOrigin = caster:GetAbsOrigin(),
    	
    	EffectName = projectile_name,
    	fDistance = projectile_distance,
    	fStartRadius = projectile_start_radius,
    	fEndRadius = projectile_end_radius,
    	bHasFrontalCone = false,
		vVelocity = projectile_direction * projectile_speed,
    	
		bDeleteOnHit = false,
    	bReplaceExisting = false,
    	-- fExpireTime = GameRules:GetGameTime() + 10.0,
    	
    	iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    	iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
    	iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- Play effects
	local sound_cast = "Hero_QueenOfPain.SonicWave"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
function queen_of_pain_sonic_wave_lua:OnProjectileHit( target, location )
	local screamDamage = self:GetSpecialValueFor("damage")

	-- Apply Damage	 
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = screamDamage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end