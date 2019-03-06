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
mars_spear_of_mars_lua = class({})
LinkLuaModifier( "modifier_mars_spear_of_mars_lua", "lua_abilities/mars_spear_of_mars_lua/modifier_mars_spear_of_mars_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_mars_spear_of_mars_lua_debuff", "lua_abilities/mars_spear_of_mars_lua/modifier_mars_spear_of_mars_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Ability Start
function mars_spear_of_mars_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/units/heroes/hero_mars/mars_spear.vpcf"
	local projectile_distance = self:GetSpecialValueFor("spear_range")
	local projectile_speed = self:GetSpecialValueFor("spear_speed")
	local projectile_radius = self:GetSpecialValueFor("spear_width")
	local projectile_vision = self:GetSpecialValueFor("spear_vision")

	-- calculate direction
	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius =projectile_radius,
		vVelocity = direction * projectile_speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		-- fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
		fVisionDuration = 10,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	local sound_cast = "Hero_Mars.Spear.Cast"
	EmitSoundOn( sound_cast, caster )
	local sound_cast = "Hero_Mars.Spear"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
-- projectile management
--[[
Fields:
- location
- direction
- init_pos
- unit
- modifier
- tree
]]
local mars_projectiles = {}
function mars_projectiles:Init( projectileID )
	self[projectileID] = {}

	-- set location
	self[projectileID].location = ProjectileManager:GetLinearProjectileLocation( projectileID )
	self[projectileID].init_pos = self[projectileID].location

	-- set direction
	local direction = ProjectileManager:GetLinearProjectileVelocity( projectileID )
	direction.z = 0
	direction = direction:Normalized()
	self[projectileID].direction = direction
end

function mars_projectiles:Destroy( projectileID )
	self[projectileID] = nil
end
mars_spear_of_mars_lua.projectiles = mars_projectiles

-- projectile hit
function mars_spear_of_mars_lua:OnProjectileHitHandle( target, location, iProjectileHandle )
	-- init in case it isn't initialized from below (if projectile launched very close to target)
	if not self.projectiles[iProjectileHandle] then
		self.projectiles:Init( iProjectileHandle )
	end

	if not target then
		-- add viewer
		local projectile_vision = self:GetSpecialValueFor("spear_vision")
		AddFOWViewer( self:GetCaster():GetTeamNumber(), location, projectile_vision, 1, false)

		-- destroy data
		self.projectiles:Destroy( iProjectileHandle )
		return
	end

	-- get stun and damage
	local stun = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("damage")

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	ApplyDamage(damageTable)

	-- check if it has skewered a unit, or target is not a hero
	if (not target:IsHero()) or self.projectiles[iProjectileHandle].unit then
		-- calculate knockback direction
		local direction = self.projectiles[iProjectileHandle].direction
		local proj_angle = VectorToAngles( direction ).y
		local unit_angle = VectorToAngles( target:GetOrigin()-location ).y
		local angle_diff = unit_angle - proj_angle
		if AngleDiff( unit_angle, proj_angle )>=0 then
			direction = RotatePosition( Vector(0,0,0), QAngle( 0, 90, 0 ), direction )
		else
			direction = RotatePosition( Vector(0,0,0), QAngle( 0, -90, 0 ), direction )
		end

		-- add sidestep modifier to other unit
		local knockback_duration = self:GetSpecialValueFor("knockback_duration")
		local knockback_distance = self:GetSpecialValueFor("knockback_distance")

		target:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_generic_knockback_lua", -- modifier name
			{
				duration = knockback_duration,
				distance = knockback_distance,
				direction_x = direction.x,
				direction_y = direction.y,
				IsFlail = false,
			} -- kv
		)

		-- play effects
		local sound_cast = "Hero_Mars.Spear.Knockback"
		EmitSoundOn( sound_cast, target )

		return false
	end

	-- add modifier to skewered unit
	local modifier = target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_mars_spear_of_mars_lua", -- modifier name
		{
			projectile = iProjectileHandle,
		} -- kv
	)
	self.projectiles[iProjectileHandle].unit = target
	self.projectiles[iProjectileHandle].modifier = modifier

	-- play effects
	local sound_cast = "Hero_Mars.Spear.Target"
	EmitSoundOn( sound_cast, target )
end

-- projectile think
function mars_spear_of_mars_lua:OnProjectileThinkHandle( iProjectileHandle )
	-- init for the first time
	if not self.projectiles[iProjectileHandle] then
		self.projectiles:Init( iProjectileHandle )
	end

	-- init data
	local search_radius = 100
	local direction = self.projectiles[iProjectileHandle].direction
	local unit = self.projectiles[iProjectileHandle].unit

	-- save location
	local location = ProjectileManager:GetLinearProjectileLocation( iProjectileHandle )
	self.projectiles[iProjectileHandle].location = location

	-- check skewered unit
	if not unit then return end

	-- search for high ground
	local base_loc = unit:GetOrigin()
	local search_loc = base_loc + direction * 80
	search_loc = GetGroundPosition( search_loc, unit )
	if search_loc.z>base_loc.z and (not GridNav:IsTraversable( search_loc )) then
		self:Pinned( iProjectileHandle )
		return
	end

	-- search for tree
	local trees = GridNav:GetAllTreesAroundPoint( location, search_radius, false)
	if #trees>0 then
		self.projectiles[iProjectileHandle].tree = trees[1]

		-- pinned
		self:Pinned( iProjectileHandle )
		return
	end

	-- search for buildings
	local buildings = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		location,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		50,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_BUILDING,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #buildings>0 then
		-- pinned
		self:Pinned( iProjectileHandle )
		return
	end
end

function mars_spear_of_mars_lua:Pinned( iProjectileHandle )
	local unit = self.projectiles[iProjectileHandle].unit
	local modifier = self.projectiles[iProjectileHandle].modifier
	local duration = self:GetSpecialValueFor("stun_duration")
	local projectile_vision = self:GetSpecialValueFor("spear_vision")

	-- add viewer
	AddFOWViewer( self:GetCaster():GetTeamNumber(), unit:GetOrigin(), projectile_vision, duration, false)

	-- destroy projectile and modifier
	ProjectileManager:DestroyLinearProjectile( iProjectileHandle )
	modifier:Destroy()

	-- set unit
	unit:SetOrigin( self.projectiles[iProjectileHandle].location )

	-- add stun modifier
	unit:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_mars_spear_of_mars_lua_debuff", -- modifier name
		{
			duration = duration,
			projectile = iProjectileHandle,
		} -- kv
	)

	-- play effects
	self:PlayEffects( iProjectileHandle, duration )
end
--------------------------------------------------------------------------------
function mars_spear_of_mars_lua:PlayEffects( projID, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_spear_impact.vpcf"
	local sound_cast = "Hero_Mars.Spear.Root"

	-- Get Data
	local delta = 40
	local unit = self.projectiles[projID].unit
	local location = self.projectiles[projID].location
	local direction = self.projectiles[projID].direction

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, unit:GetOrigin() + direction*delta )
	ParticleManager:SetParticleControl( effect_cast, 1, direction*1000 )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:SetParticleControlForward( effect_cast, 0, direction )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, unit )
end