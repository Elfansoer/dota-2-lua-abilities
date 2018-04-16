abaddon_mist_coil_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function abaddon_mist_coil_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local self_damage = self:GetSpecialValueFor("self_damage")

	local projectile_speed = self:GetSpecialValueFor("missile_speed")
	local projectile_name = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf"

	-- logic
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- self damage
	local damageTable = {
		victim = caster,
		attacker = caster,
		damage = self_damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- Play effects
	self:PlayEffects()
end
--------------------------------------------------------------------------------
-- Projectile
function abaddon_mist_coil_lua:OnProjectileHit( target, location )
	-- check if enemy or ally
	local ally = false
	if target:GetTeamNumber()==self:GetCaster():GetTeamNumber() then
		ally = true
	end

	if ally then
		-- ally logic
		local heal_amount = self:GetSpecialValueFor("heal_amount")
		target:Heal( heal_amount, self:GetCaster() )
	else
		-- enemy logic
		-- cancel if linken
		if target:IsInvulnerable() or target:TriggerSpellAbsorb( self ) then
			return
		end

		local target_damage = self:GetSpecialValueFor("target_damage")
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = target_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)
	end

	-- Play effects
	local sound_target = "Hero_Abaddon.DeathCoil.Target"
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
function abaddon_mist_coil_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_death_coil_abaddon.vpcf"
	local sound_cast = "Hero_Abaddon.DeathCoil.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end