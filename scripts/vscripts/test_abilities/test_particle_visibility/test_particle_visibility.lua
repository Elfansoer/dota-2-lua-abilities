-- Created by Elfansoer

--------------------------------------------------------------------------------
test_particle_visibility = class({})
LinkLuaModifier( "modifier_test_particle_visibility", "lua_abilities/test_particle_visibility/modifier_test_particle_visibility", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function test_particle_visibility:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local direction = (point-caster:GetOrigin())
	direction.z = 0
	direction = direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = "",
	    fDistance = (point-caster:GetOrigin()):Length2D(),
	    fStartRadius = 100,
	    fEndRadius =100,
		vVelocity = direction * 1000,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	self:PlayEffects( point )
end
--------------------------------------------------------------------------------
-- Projectile
function test_particle_visibility:OnProjectileHit( target, location )
	if not target then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end

	return false
end

function test_particle_visibility:OnProjectileThink( loc )
	ParticleManager:SetParticleControl( self.effect_cast, 1, loc )
end
--------------------------------------------------------------------------------
function test_particle_visibility:PlayEffects( point )
	local origin = self:GetCaster():GetOrigin()

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 1, 50 )
	-- ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 0, 50 )
	-- ParticleManager:SetParticleFoWProperties( self.effect_cast, 0, 0, 50 )

	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		0,
		self:GetCaster(),
		PATTACH_CUSTOMORIGIN_FOLLOW,
		"attach_hitloc",
		origin, -- unknown
		true -- unknown, true
	)
	-- ParticleManager:SetParticleControl( self.effect_cast, 0, origin )
	ParticleManager:SetParticleControl( self.effect_cast, 1, origin )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(1000,0,0) )
	ParticleManager:SetParticleShouldCheckFoW( self.effect_cast, true )

	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
end

--[[
Result:
- SetParticleShouldCheckFoW forces particles to use FOW or not

Tests:
	----
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	Point 0 follows caster

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 1, 50 )
	- Allies: Unseen if 1 is hidden
	- Enemies: Unseen if caster is unseen

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 0, 1, 50 )
	- Allies: Always seen
	- Enemies: Unseen if caster is unseen

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 0, 50 )
	- Allies: Always seen
	- Enemies: Unseen if caster is unseen

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 0, 0, 50 )
	- Allies: Always seen
	- Enemies: Unseen if caster is unseen

	----
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	Point 0 NOT following caster

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 1, 50 )
	- Allies: Unseen if 1 is hidden
	- Enemies: Unseen if 1 is hidden

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 0, 1, 50 )
	- Allies:
		Unseen if none of 0 or 1 is seen
		Once seen cannot be unseen
		There's delay from 'seeing' 0
	- Enemies:
		Same as allies

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 1, 0, 50 )
	Same as above

	ParticleManager:SetParticleFoWProperties( self.effect_cast, 0, 0, 50 )
	- Allies: Unseen if 0 is hidden
	- Enemies: Unseen if 0 is hidden

	----
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN_FOLLOW, self:GetCaster() )
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster() )
	same as ( PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
]]
