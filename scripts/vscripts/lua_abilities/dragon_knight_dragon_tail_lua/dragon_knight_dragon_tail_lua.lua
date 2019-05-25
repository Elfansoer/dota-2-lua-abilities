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
dragon_knight_dragon_tail_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
-- function dragon_knight_dragon_tail_lua:GetAOERadius()
-- 	return self:GetSpecialValueFor( "radius" )
-- end

-- function dragon_knight_dragon_tail_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end


--------------------------------------------------------------------------------
-- Ability Start
function dragon_knight_dragon_tail_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- check dragon modifier
	local modifier = caster:FindModifierByNameAndCaster( "pszScriptName", caster )

	-- check if simple form
	if not modifier then
		-- directly hit
		self:Hit( target )

		-- play effects
		local sound_cast = "Hero_DragonKnight.DragonTail.Cast"
		EmitSoundOn( sound_cast, caster )
		return
	end

	-- dragon form

	-- get data
	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
		}
	ProjectileManager:CreateTrackingProjectile(info)

	-- play 
end

-- Helper
function dragon_knight_dragon_tail_lua:Hit( target )
	local caster = self:GetCaster()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local damage = self:GetAbilityDamage()
	local duration = self:GetSpecialValueFor( "stun_duration" )

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- stun
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	local sound_cast = "Hero_DragonKnight.DragonTail.Target"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Projectile
function dragon_knight_dragon_tail_lua:OnProjectileHit( target, location )
	if not target then return end

	self:Hit( target )
end

-- --------------------------------------------------------------------------------
-- function dragon_knight_dragon_tail_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end