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
magnus_shockwave_lua = class({})
LinkLuaModifier( "modifier_magnus_shockwave_lua", "lua_abilities/magnus_shockwave_lua/modifier_magnus_shockwave_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Init Abilities
function magnus_shockwave_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave_cast.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_skewer_debuff.vpcf", context )
end
--------------------------------------------------------------------------------
-- Ability Start
function magnus_shockwave_lua:OnAbilityPhaseStart()
	if not IsServer() then return end

	-- play effects
	self:PlayEffects1()

	return true
end

function magnus_shockwave_lua:OnAbilityPhaseInterrupted()
	if not IsServer() then return end

	-- stop effects
	self:StopEffects1( true )
end

--------------------------------------------------------------------------------
-- Ability Start
function magnus_shockwave_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- stop effects
	self:StopEffects1( false )

	-- load data
	local name = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf"
	local distance = self:GetCastRange( point, nil )
	local radius = self:GetSpecialValueFor( "shock_width" )
	local speed = self:GetSpecialValueFor( "shock_speed" )

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = true,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = name,
	    fDistance = distance,
	    fStartRadius = radius,
	    fEndRadius = radius,
		vVelocity = direction * speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	local sound_cast = "Hero_Magnataur.ShockWave.Particle"
	EmitSoundOn( sound_cast, caster )
end
--------------------------------------------------------------------------------
-- Projectile
function magnus_shockwave_lua:OnProjectileHit( target, location )
	if not target then return end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor( "shock_damage" )
	local duration = self:GetSpecialValueFor( "basic_slow_duration" )

	local pull_duration = self:GetSpecialValueFor( "pull_duration" )
	local pull_distance = self:GetSpecialValueFor( "pull_distance" )

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- pull
	local mod = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			target_x = location.x,
			target_y = location.y,
			duration = pull_duration,
			distance = pull_distance,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)

	-- slow
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_magnus_shockwave_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	self:PlayEffects2( target, mod )

	return false
end

--------------------------------------------------------------------------------
-- Effects
function magnus_shockwave_lua:PlayEffects2( target, mod )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf"
	local sound_cast = "Hero_Magnataur.ShockWave.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	mod:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

function magnus_shockwave_lua:PlayEffects1()
	local caster = self:GetCaster()

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_magnataur/magnataur_shockwave_cast.vpcf"
	local sound_cast = "Hero_Magnataur.ShockWave.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end

function magnus_shockwave_lua:StopEffects1( interrupted )
	ParticleManager:DestroyParticle( self.effect_cast, interrupted )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

	local sound_cast = "Hero_Magnataur.ShockWave.Cast"
	StopSoundOn( sound_cast, self:GetCaster() )
end