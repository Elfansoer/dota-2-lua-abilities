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
test_sandbox_notarget = class({})
LinkLuaModifier( "modifier_test_sandbox_notarget", "lua_abilities/test_sandbox_notarget/modifier_test_sandbox_notarget", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- function test_sandbox_notarget:GetBehavior()

-- end

-- -- AOE Radius
-- function test_sandbox_notarget:GetAOERadius()
-- 	return self:GetSpecialValueFor( "radius" )
-- end

-- -- CD
-- function test_sandbox_notarget:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Start
function test_sandbox_notarget:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	print("incoming tracking projectile",caster.GetIncomingTrackingProjectiles)

end
--------------------------------------------------------------------------------
-- Projectile
function test_sandbox_notarget:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
function test_sandbox_notarget:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
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