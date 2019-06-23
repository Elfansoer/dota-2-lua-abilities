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
LinkLuaModifier( "modifier_alchemist_unstable_concoction_lua", "lua_abilities/alchemist_unstable_concoction_lua/modifier_alchemist_unstable_concoction_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- MAIN
--------------------------------------------------------------------------------
alchemist_unstable_concoction_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function alchemist_unstable_concoction_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "brew_explosion" )

	-- add brewing modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_alchemist_unstable_concoction_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- check sister ability
	local ability = caster:FindAbilityByName( "alchemist_unstable_concoction_throw_lua" )
	if not ability then
		ability = caster:AddAbility( "alchemist_unstable_concoction_throw_lua" )
		ability:SetStolen( true )
	end

	-- check ability level
	ability:SetLevel( self:GetLevel() )

	-- switch ability layout
	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)
end

--------------------------------------------------------------------------------
-- THROW
--------------------------------------------------------------------------------
alchemist_unstable_concoction_throw_lua = class({})

--------------------------------------------------------------------------------
-- Custom KV
function alchemist_unstable_concoction_throw_lua:GetAOERadius()
	return self:GetSpecialValueFor( "midair_explosion_radius" )
end

--------------------------------------------------------------------------------
-- Ability Event
function alchemist_unstable_concoction_throw_lua:OnUpgrade()
	-- if somehow a player got cornered enough to level up Concoction during throw, sync level
	local ability = self:GetCaster():FindAbilityByName( "alchemist_unstable_concoction_lua" )
	ability:SetLevel( self:GetLevel() )
end


--------------------------------------------------------------------------------
-- Ability Start
function alchemist_unstable_concoction_throw_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local max_brew = self:GetSpecialValueFor( "brew_time" )
	local projectile_name = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "movement_speed" )
	local projectile_vision = self:GetSpecialValueFor( "vision_range" )

	-- obtain brewing time
	local brew_time

	local modifier = caster:FindModifierByName( "modifier_alchemist_unstable_concoction_lua" )
	if modifier then
		 -- cast by sister ability
		brew_time = math.min( GameRules:GetGameTime()-modifier:GetCreationTime(), max_brew )
		modifier:Destroy()

	elseif alchemist_unstable_concoction_throw_lua.reflected_brew_time then
		-- reflected
		brew_time = alchemist_unstable_concoction_throw_lua.reflected_brew_time

	elseif self.stored_brew_time then
		-- recast ( Multicast, Soul bind )
		brew_time = self.stored_brew_time

	else
		-- unknown
		brew_time = 0
	end

	--  store brew time in instance variable for later recast (e.g. Multicast)
	self.brew_time = brew_time

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                           -- Optional
	
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = projectile_vision,                              -- Optional
		iVisionTeamNumber = caster:GetTeamNumber(),        -- Optional
		ExtraData = {
			brew_time = brew_time,
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Throw"
	EmitSoundOn( sound_cast, caster )

	-- switch ability layout
	local ability = caster:FindAbilityByName( "alchemist_unstable_concoction_lua" )
	if not ability then return end -- reflected

	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)
end

--------------------------------------------------------------------------------
-- Projectile
function alchemist_unstable_concoction_throw_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not target then return end

	-- obtain data
	local brew_time = ExtraData.brew_time

	-- unique reflect interaction
	-- store brew time to static class variable
	alchemist_unstable_concoction_throw_lua.reflected_brew_time = brew_time

	-- check if the ability GOT TRIGGERED BY SOMETHING TRIVIAL
	local TRIGGERED = target:TriggerSpellAbsorb( self )

	-- clean up static variable
	alchemist_unstable_concoction_throw_lua.reflected_brew_time = nil

	-- calm down if you GOT TRIGGERED
	if TRIGGERED then return end

	-- load data
	local max_brew = self:GetSpecialValueFor( "brew_time" )
	local min_stun = self:GetSpecialValueFor( "min_stun" )
	local max_stun = self:GetSpecialValueFor( "max_stun" )
	local min_damage = self:GetSpecialValueFor( "min_damage" )
	local max_damage = self:GetSpecialValueFor( "max_damage" )
	local radius = self:GetSpecialValueFor( "midair_explosion_radius" )

	-- calculate stun and damage
	local stun = (brew_time/max_brew)*(max_stun-min_stun) + min_stun
	local damage = (brew_time/max_brew)*(max_damage-min_damage) + min_damage

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- find units in radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- debuff
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = stun } -- kv
		)
	end

	-- Play effects
	self:PlayEffects( target )
end

------------------------------------------------------------------------------
function alchemist_unstable_concoction_throw_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf"
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end