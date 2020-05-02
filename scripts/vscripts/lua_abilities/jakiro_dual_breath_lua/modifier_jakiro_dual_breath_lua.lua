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
modifier_jakiro_dual_breath_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_dual_breath_lua:IsHidden()
	return true
end

function modifier_jakiro_dual_breath_lua:IsDebuff()
	return false
end

function modifier_jakiro_dual_breath_lua:IsStunDebuff()
	return false
end

function modifier_jakiro_dual_breath_lua:IsPurgable()
	return false
end

function modifier_jakiro_dual_breath_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_jakiro_dual_breath_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_dual_breath_lua:OnCreated( kv )
	-- references
	local distance = self:GetAbility():GetSpecialValueFor( "range" )
	local start_radius = self:GetAbility():GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetAbility():GetSpecialValueFor( "end_radius" )
	self.speed_ice = self:GetAbility():GetSpecialValueFor( "speed" )
	self.speed_fire = self:GetAbility():GetSpecialValueFor( "speed_fire" )

	if not IsServer() then return end
	local caster = self:GetCaster()

	-- calculate direction
	self.direction = Vector( kv.x, kv.y, 0 ) - caster:GetOrigin()
	self.direction.z = 0
	self.direction = self.direction:Normalized()

	-- precache projectile
	self.info = {
		Source = caster,
		Ability = self:GetAbility(),
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    -- EffectName = projectile_name,
	    fDistance = distance,
	    fStartRadius = start_radius,
	    fEndRadius = end_radius,
		-- vVelocity = projectile_direction * speed_ice,
	}

	-- launch ice projectile
	-- this projectile needs a cp to set, so it looks ugly.... but eeh
	self.info.EffectName = "particles/units/heroes/hero_jakiro/jakiro_dual_breath_ice.vpcf"
	self.info.vVelocity = self.direction * self.speed_ice
	self.info.ExtraData = {
		fire = 0
	}
	ProjectileManager:CreateLinearProjectile( self.info )

	-- play effects
	local sound_cast = "Hero_Jakiro.DualBreath.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function modifier_jakiro_dual_breath_lua:OnRefresh( kv )
	
end

function modifier_jakiro_dual_breath_lua:OnRemoved()
	if not IsServer() then return end

	-- launch fire projectile
	self.info.EffectName = "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire.vpcf"
	self.info.vVelocity = self.direction * self.speed_fire
	self.info.ExtraData = {
		fire = 1
	}
	ProjectileManager:CreateLinearProjectile( self.info )

	-- play effects
	self:PlayEffects()
end

function modifier_jakiro_dual_breath_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_dual_breath_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_dual_breath_fire_launch_2.vpcf"

	local caster = self:GetCaster()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self.info.vVelocity )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		9,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end