-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
hwei_devastating_fire = class({})

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_devastating_fire:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_devastating_fire:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- set up projectile
	local projectile_name = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf"
	local distance = self:GetCastRange( point, nil )
	local start_radius = self:GetSpecialValueFor( "width" )
	local end_radius = self:GetSpecialValueFor( "width" )
	local speed = self:GetSpecialValueFor( "speed" )

	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- create linear projectile
	local info = {
		Source = self:GetCaster(),
		Ability = self,
		vSpawnOrigin = caster:GetOrigin(),
	    
		bDeleteOnHit = true,

	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = distance,
	    fStartRadius = start_radius,
	    fEndRadius = end_radius,
		vVelocity = direction * speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- effects
	EmitSoundOn( "Hero_Grimstroke.DarkArtistry.PreCastPoint", caster )
end

--------------------------------------------------------------------------------
-- Projectile
function hwei_devastating_fire:OnProjectileHit( target, location )
	local point = location
	if target then
		point = target:GetOrigin()
	end

	local radius = self:GetSpecialValueFor( "radius" )
	local damage = self:GetSpecialValueFor( "damage" )
	local damage_pct = self:GetSpecialValueFor( "max_health_pct" )

	-- explode at the center of the target
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

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		-- damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		damageTable.damage = damage + damage_pct * enemy:GetMaxHealth() / 100
		ApplyDamage( damageTable )		
	end

	self:PlayEffects( point, radius )

	return true
end

--------------------------------------------------------------------------------
-- Effects
function hwei_devastating_fire:PlayEffects( location, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf"
	local sound_cast = "Ability.LightStrikeArray"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, location )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( location, sound_cast, self:GetCaster() )
end