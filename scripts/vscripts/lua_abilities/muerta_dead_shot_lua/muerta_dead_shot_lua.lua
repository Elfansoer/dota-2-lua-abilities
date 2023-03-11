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
muerta_dead_shot_lua = class({})
LinkLuaModifier( "modifier_muerta_dead_shot_lua", "lua_abilities/muerta_dead_shot_lua/modifier_muerta_dead_shot_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_muerta_dead_shot_lua_slow", "lua_abilities/muerta_dead_shot_lua/modifier_muerta_dead_shot_lua_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function muerta_dead_shot_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_debuff_slow.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear_tree.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf", context )
end

function muerta_dead_shot_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function muerta_dead_shot_lua:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function muerta_dead_shot_lua:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	local ricochet_radius_start = self:GetSpecialValueFor( "ricochet_radius_start" )
	local ricochet_radius_end = self:GetSpecialValueFor( "ricochet_radius_end" )

	-- primary cast unit
	-- NOTE: We don't know how to get tree entity is currently targeted in Panorama yet. Only units.
	if unit then
		self.is_primary_unit = true
		self.client_vector_target = unit
	else
		self.is_primary_unit = false
		self.client_vector_target = position or self:GetCaster():GetAbsOrigin()
	end

	-- create particle
	local particle_cast = "particles/ui_mouseactions/range_finder_cone.vpcf"
	self.indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.indicator, 3, Vector( ricochet_radius_start, ricochet_radius_end, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 4, Vector( 0, 255, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 6, Vector( 1, 0, 0 ) )

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function muerta_dead_shot_lua:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local ricochet_range = self:GetCastRange( position, unit ) * self:GetSpecialValueFor( "ricochet_distance_multiplier" )
	local origin_pos = self.client_vector_target
	if self.is_primary_unit then
		origin_pos = self.client_vector_target:GetAbsOrigin()
	end

	local direction = position - origin_pos
	direction.z = 0
	direction = direction:Normalized()

	local end_pos = origin_pos + direction * ricochet_range

	-- update particle
	ParticleManager:SetParticleControl( self.indicator, 1, origin_pos )
	ParticleManager:SetParticleControl( self.indicator, 2, end_pos )
end

function muerta_dead_shot_lua:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end
	self.is_primary_unit = nil
	self.client_vector_target  = nil

	-- destroy particle
	ParticleManager:DestroyParticle(self.indicator, false)
	ParticleManager:ReleaseParticleIndex(self.indicator)
	self.indicator = nil
end

--------------------------------------------------------------------------------
-- Ability Start
muerta_dead_shot_lua.projectiles = {}
function muerta_dead_shot_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local vector_point = self.vector_position
	if not vector_point then
		-- likely reflected, otherwise set forward as default
		vector_point = muerta_dead_shot_lua.reflect_location or (target:GetOrigin() + target:GetForwardVector())
	end

	-- load data
	local speed = self:GetSpecialValueFor( "speed" )
	local damage = self:GetSpecialValueFor( "damage" )

	local effect_name_tracking = "particles/units/heroes/hero_muerta/muerta_deadshot_tracking_proj.vpcf"
	local effect_name_tree = "particles/units/heroes/hero_muerta/muerta_deadshot_linear_tree.vpcf"

	-- calculate ricochet direction
	local direction = vector_point - target:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	if target:GetClassname()=="ent_dota_tree" then
		-- if tree
		local tree_radius = self:GetSpecialValueFor( "radius" )
		local tree_direction = target:GetOrigin() - caster:GetOrigin()
		local tree_distance = tree_direction:Length2D()
		tree_direction.z = 0
		tree_direction = tree_direction:Normalized()

		-- create linear projectile
		local info = {
			Source = caster,
			Ability = self,
			vSpawnOrigin = caster:GetOrigin() + Vector(0,0,200),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
			
			bDeleteOnHit = true,
			
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_NONE,
			
			EffectName = effect_name_tree,
			fDistance = tree_distance,
			fStartRadius = tree_radius,
			fEndRadius = tree_radius,
			vVelocity = tree_direction * speed,
		
			bProvidesVision = true,
			iVisionRadius = tree_radius,
			iVisionTeamNumber = caster:GetTeamNumber(),
		}
		local projID = ProjectileManager:CreateLinearProjectile( info )

		local data = {}
		self.projectiles[projID] = data
		data.info = info
		data.OnDestroy = function( this, location )
			return self:OnTreeHit( target, direction, location )
		end
	else
		-- target unit

		-- Create Tracking Projectile
		local info = {
			Source = caster,
			Target = target,
			Ability = self,
			iMoveSpeed = speed,
			EffectName = effect_name_tracking,
			bDodgeable = true,
		}
		local projID = ProjectileManager:CreateTrackingProjectile( info )

		local data = {}
		self.projectiles[projID] = data
		data.info = info
		data.OnHit = function( this, target, location )
			return self:OnInitialHit( direction, target, location )
		end
	end

	EmitSoundOn( "Hero_Muerta.DeadShot.Cast", caster )
	EmitSoundOn( "Hero_Muerta.DeadShot.Layer", caster )
end

function muerta_dead_shot_lua:OnTreeHit( tree, direction, location )
	-- ricochet
	self:LaunchRicochet( tree, direction )
	GridNav:DestroyTreesAroundPoint(tree:GetOrigin(), 0, true)

	EmitSoundOnLocationWithCaster( location, "Hero_Muerta.DeadShot.Tree", self:GetCaster() )
end

function muerta_dead_shot_lua:OnInitialHit( direction, target, location )
	local caster = self:GetCaster()

	if target:IsMagicImmune() or target:IsInvulnerable() then return end

	-- NOTE: Lotus reflects direction to the opposite of original cast
	-- this code below create static variable for reflected ability to use
	muerta_dead_shot_lua.reflect_location = caster:GetOrigin() - direction
	muerta_dead_shot_lua.reflected = true
	local reflect = target:TriggerSpellAbsorb( self )
	muerta_dead_shot_lua.reflect_location = nil
	muerta_dead_shot_lua.reflected = nil

	if reflect then return end

	local damage = self:GetSpecialValueFor( "damage" )
	local slow_duration = self:GetSpecialValueFor( "impact_slow_duration" )
	
	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- slow
	target:AddNewModifier(
		caster,
		self,
		"modifier_muerta_dead_shot_lua_slow",
		{duration = slow_duration}
	)

	-- ricochet
	self:LaunchRicochet( target, direction )

	EmitSoundOn( "Hero_Muerta.DeadShot.Slow", target )
end

function muerta_dead_shot_lua:LaunchRicochet( target, direction )
	local caster = self:GetCaster()

	local effect_name_linear = "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf"
	local speed = self:GetSpecialValueFor( "speed" )
	local ricochet_radius_start = self:GetSpecialValueFor( "ricochet_radius_start" )
	local ricochet_radius_end = self:GetSpecialValueFor( "ricochet_radius_end" )
	local ricochet_distance = self:GetCastRange(target:GetOrigin(), target) * self:GetSpecialValueFor( "ricochet_distance_multiplier" )

	-- linear projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = target:GetOrigin(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		
		bDeleteOnHit = false,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = effect_name_linear,
		fDistance = ricochet_distance,
		fStartRadius = ricochet_radius_start,
		fEndRadius = ricochet_radius_end,
		vVelocity = direction * speed,
	
		bProvidesVision = true,
		iVisionRadius = ricochet_radius_start,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}
	local projID = ProjectileManager:CreateLinearProjectile( info )

	local data = {}
	self.projectiles[projID] = data
	data.info = info_ricochet
	data.OnHit = function( this, ricochet_target, location )
		return self:OnRicochetHit( target, ricochet_target, location, direction )
	end

	EmitSoundOnLocationWithCaster(target:GetOrigin(), "Hero_Muerta.DeadShot.Ricochet", caster)
end

function muerta_dead_shot_lua:OnRicochetHit( initial_target, target, location, direction )
	if target==initial_target then return false end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor( "damage" )
	local fear_duration = self:GetSpecialValueFor( "ricochet_fear_duration" )

	-- damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	EmitSoundOn( "Hero_Muerta.DeadShot.Damage", target )

	if target:IsRealHero() then
		-- apply fear
		target:AddNewModifier(
			caster,
			self,
			"modifier_muerta_dead_shot_lua",
			{duration = fear_duration}
		):Init( direction )

		EmitSoundOn( "Hero_Muerta.DeadShot.Ricochet.Impact", target )
		return true
	end

	self:PlayEffects( target )

	return false
end

--------------------------------------------------------------------------------
-- Projectile
function muerta_dead_shot_lua:OnProjectileThinkHandle( handle )
	local data = self.projectiles[handle]
	if not data then return end

	local pos = ProjectileManager:GetLinearProjectileLocation( handle )

	if data.OnThink then
		data:OnThink( pos )
	end
end

function muerta_dead_shot_lua:OnProjectileHitHandle( target, location, handle )
	local data = self.projectiles[handle]
	if not data then return end

	if not target then
		if data.OnDestroy then
			data:OnDestroy( location )
		end
		self.projectiles[handle] = nil
		return
	end

	if data.OnHit then
		return data:OnHit( target, location )
	end
end

--------------------------------------------------------------------------------
-- Effects
function muerta_dead_shot_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_deadshot_creep_impact.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end