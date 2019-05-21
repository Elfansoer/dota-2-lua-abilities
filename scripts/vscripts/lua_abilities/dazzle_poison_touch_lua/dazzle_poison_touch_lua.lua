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
dazzle_poison_touch_lua = class({})
LinkLuaModifier( "modifier_dazzle_poison_touch_lua", "lua_abilities/dazzle_poison_touch_lua/modifier_dazzle_poison_touch_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function dazzle_poison_touch_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local origin = caster:GetOrigin()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local max_targets = self:GetSpecialValueFor( "targets" )
	local distance = self:GetSpecialValueFor( "end_distance" )
	local start_radius = self:GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetSpecialValueFor( "end_radius" )

	-- get direction
	local direction = target:GetOrigin()-origin
	direction.z = 0
	direction = direction:Normalized()

	local enemies = self:FindUnitsInCone(
		caster:GetTeamNumber(),	-- nTeamNumber
		target:GetOrigin(),	-- vCenterPos
		caster:GetOrigin(),	-- vStartPos
		caster:GetOrigin() + direction*distance,	-- vEndPos
		start_radius,	-- fStartRadius
		end_radius,	-- fEndRadius
		nil,	-- hCacheUnit
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- nTeamFilter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- nTypeFilter
		0,	-- nFlagFilter
		FIND_CLOSEST,	-- nOrderFilter
		false	-- bCanGrowCache
	)

	-- projectile data
	local projectile_name = "particles/units/heroes/hero_dazzle/dazzle_poison_touch.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- precache projectile
	local info = {
		-- Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
	
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = false,                           -- Optional
	}

	-- create projectile
	local counter = 0
	for _,enemy in pairs(enemies) do
		info.Target = enemy
		ProjectileManager:CreateTrackingProjectile(info)

		counter = counter+1
		if counter>=max_targets then break end
	end

	-- Play effects
	local sound_cast = "Hero_Dazzle.Poison_Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
function dazzle_poison_touch_lua:OnProjectileHit( target, location )
	if not target then return end

	-- get data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add debuff
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_dazzle_poison_touch_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	local sound_target = "Hero_Dazzle.Poison_Touch"
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Helper
function dazzle_poison_touch_lua:FindUnitsInCone( nTeamNumber, vCenterPos, vStartPos, vEndPos, fStartRadius, fEndRadius, hCacheUnit, nTeamFilter, nTypeFilter, nFlagFilter, nOrderFilter, bCanGrowCache )
	-- vCenterPos is used to determine searching center (FIND_CLOSEST will refer to units closest to vCenterPos)

	-- get cast direction and length distance
	local direction = vEndPos-vStartPos
	direction.z = 0

	local distance = direction:Length2D()
	direction = direction:Normalized()

	-- get max radius circle search
	local big_radius = distance + math.max(fStartRadius, fEndRadius)

	-- find enemies closest to primary target within max radius
	local units = FindUnitsInRadius(
		nTeamNumber,	-- int, your team number
		vCenterPos,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		big_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		nTeamFilter,	-- int, team filter
		nTypeFilter,	-- int, type filter
		nFlagFilter,	-- int, flag filter
		nOrderFilter,	-- int, order filter
		bCanGrowCache	-- bool, can grow cache
	)

	-- Filter within cone
	local targets = {}
	for _,unit in pairs(units) do

		-- get unit vector relative to vStartPos
		local vUnitPos = unit:GetOrigin()-vStartPos

		-- get projection scalar of vUnitPos onto direction using dot-product
		local fProjection = vUnitPos.x*direction.x + vUnitPos.y*direction.y + vUnitPos.z*direction.z

		-- clamp projected scalar to [0,distance]
		fProjection = math.max(math.min(fProjection,distance),0)
		
		-- get projected vector of vUnitPos onto direction
		local vProjection = direction*fProjection

		-- calculate distance between vUnitPos and the projected vector
		local fUnitRadius = (vUnitPos - vProjection):Length2D()

		-- calculate interpolated search radius at projected vector
		local fInterpRadius = (fProjection/distance)*(fEndRadius-fStartRadius) + fStartRadius

		-- if unit is within distance, add them
		if fUnitRadius<=fInterpRadius then
			table.insert( targets, unit )
		end
	end

	return targets
end