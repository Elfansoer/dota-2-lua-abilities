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
venomancer_venomous_gale_lua = class({})
LinkLuaModifier( "modifier_venomancer_venomous_gale_lua", "lua_abilities/venomancer_venomous_gale_lua/modifier_venomancer_venomous_gale_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function venomancer_venomous_gale_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", context )
end

function venomancer_venomous_gale_lua:Spawn()
	self.particles = {
		"particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf",
		"particles/units/heroes/hero_venomancer/venomancer_venomous_gale_impact.vpcf",
		"particles/units/heroes/hero_venomancer/venomancer_gale_poison_debuff.vpcf",
	}

	self.sounds = {
		"Hero_Venomancer.VenomousGale",
		"Hero_Venomancer.VenomousGaleImpact",
	}
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function venomancer_venomous_gale_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function venomancer_venomous_gale_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor( "radius" )
	local speed = self:GetSpecialValueFor( "speed" )
	local range = self:GetCastRange( point, target )
	local vision = 280

	-- get direction
	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- linear projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = false,

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = self.particles[1],
		fDistance = range,
		fStartRadius = radius,
		fEndRadius = radius,
		vVelocity = direction * speed,

		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	EmitSoundOn( self.sounds[1], caster  )
end
--------------------------------------------------------------------------------
-- Projectile
function venomancer_venomous_gale_lua:OnProjectileHit( target, location )
	if not target then return end

	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_venomancer_venomous_gale_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	self:PlayEffects( target )
end

function venomancer_venomous_gale_lua:PlayEffects( target )
	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( self.particles[2], PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( self.sounds[2], target )
end