-- Created by Elfansoer
--[[
- Check False/True piercing projectile
- Projectile Events
	Launch: Projectile launched
	Think: Projectile in flight
	Hit: Projectile hits target
		- pierce procs multiple times
		- nonpierce procs once or none if disjointed
	End: Piercing ended, Non-piercing hits target (same with ProjHit)
		- pierce has no target
		- nonpierce has target, if disjointed no target
- Issues
	- Red help when dominated
	- bounce area still undefined
	- spark area modifier still undefined
	- breach area modifier still unclear
		help, mask, tap is duration, duration, radius
	- ping area hit is too good
	- Switch area modifier is unclear
	- Breach castrange does not affect GetCastRange
- Test issues
	- Client/Panorama update should be broadcast to all client (minor)
	- enemy modifiers should have greyed out in panorama (minor)
- Improvements
	- Replace install uninstall by loop instead of hardcode name1 name2
	- set cast range as abilityspecial
	- "Modifier" to "Upgrade"
	- mark for deletion delayed by existing projectiles/buffs
	- mask casting abilities has delay to de-invis
- not in progress
	- bounce upgrade area
	- spark upgrade area
	- help upgrade concept (illusion is not good)
]]

require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_area" )

--------------------------------------------------------------------------------
-- Game Modifiers
LinkLuaModifier( "modifier_red_transistor_access_modifiers", "custom_abilities/red_transistor_access/modifier_red_transistor_access_modifiers", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_bounce_area", "custom_abilities/red_transistor_access/modifier_red_transistor_bounce_area", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_breach_castrange", "custom_abilities/red_transistor_access/modifier_red_transistor_breach_castrange", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_flood_thinker", "custom_abilities/red_transistor_access/modifier_red_transistor_flood_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_flood_damage", "custom_abilities/red_transistor_access/modifier_red_transistor_flood_damage", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_get_pull", "custom_abilities/red_transistor_access/modifier_red_transistor_get_pull", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_red_transistor_ping_cooldown", "custom_abilities/red_transistor_access/modifier_red_transistor_ping_cooldown", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_ping_toggle", "custom_abilities/red_transistor_access/modifier_red_transistor_ping_toggle", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_purge_debuff", "custom_abilities/red_transistor_access/modifier_red_transistor_purge_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_switch_debuff", "custom_abilities/red_transistor_access/modifier_red_transistor_switch_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Base Projectile abilities
--------------------------------------------------------------------------------
generic_projectile = class({})
generic_projectile.modifiers = {}

--------------------------------------------------------------------------------
-- Init Abilities
function generic_projectile:Precache( context )
	-- PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_generic_projectile.vsndevts", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_generic_projectile/generic_projectile.vpcf", context )
end

function generic_projectile:Spawn()
	if not IsServer() then return end
	self.modifiers = self.modifiers or {}
end

--------------------------------------------------------------------------------
-- Install/Uninstall
function generic_projectile:Install( access, name1, name2 )
	self.access = access
	self.kv = access.kv

	if name1 then
		self.modifiers[1] = access.abilities[name1]
		self.modifiers[1]:ModifierInstall( self )
	end
	if name2 then
		self.modifiers[2] = access.abilities[name2]
		self.modifiers[2]:ModifierInstall( self )
	end

	-- set access modifier (for client purposes)
	local caster = self:GetCaster()
	self.access_modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_access_modifiers", -- modifier name
		{} -- kv
	)

	-- set stack
	local id = access.ability_index[ self:GetAbilityName() ]
	local id1 = access.ability_index[ name1 ]
	local id2 = access.ability_index[ name2 ]
	local stack = 10000*id2 + 100*id1 + id
	self.access_modifier:SetStackCount( stack )

	-- set install base
	self:InstallBase()
end

function generic_projectile:Uninstall()
	for _,modifier in pairs(self.modifiers) do
		modifier:ModifierUninstall( self )
	end

	-- destroy access modifier
	if self.access_modifier and (not self.access_modifier:IsNull()) then
		self.access_modifier:Destroy()
		self.access_modifier = nil
	end

	self.modifiers = {}

	-- set uninstall base
	self:UninstallBase()
end

function generic_projectile:Replace( access, name1, name2 )
	if name1 then
		self.modifiers[1]:ModifierUninstall( self )
		self.modifiers[1] = access.abilities[name1]
		self.modifiers[1]:ModifierInstall( self )

		-- update access modifier
		if self.access_modifier and (not self.access_modifier:IsNull()) then
			local stack = self.access_modifier:GetStackCount()
			local old_id = math.floor(stack/100)%100
			local id1 = access.ability_index[ name1 ]
			stack = stack - old_id*100 + id1*100
			self.access_modifier:SetStackCount( stack )
		end
	end
	if name2 then
		self.modifiers[2]:ModifierUninstall( self )
		self.modifiers[2] = access.abilities[name2]
		self.modifiers[2]:ModifierInstall( self )

		-- update access modifier
		if self.access_modifier and (not self.access_modifier:IsNull()) then
			local stack = self.access_modifier:GetStackCount()
			local old_id = math.floor(stack/10000)%100
			local id2 = access.ability_index[ name2 ]
			stack = stack - old_id*10000 + id2*10000
			self.access_modifier:SetStackCount( stack )
		end
	end
end

--------------------------------------------------------------------------------
-- Upgrade
function generic_projectile:OnUpgrade()
	if self.access and (not self.access.lock) then
		self.access:EventUpgrade( self )
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function generic_projectile:OnSpellStart()
	-- basic reference
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- direction
	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- unique projectile properties
	local projectile = {
		name = "projectile_name",
		distance = self:GetCastRange( point, nil ),
		radius = self:GetSpecialValueFor( "radius" ),
		speed = self:GetSpecialValueFor( "speed" ),
		pierce = self:GetSpecialValueFor( "pierce" ),
		direction_x = direction.x,
		direction_y = direction.y,
		origin_x = caster:GetOrigin().x,
		origin_y = caster:GetOrigin().y,
	}

	-- call launch event
	self:OnProjectileLaunch( projectile )

	local info = self:ProcessProjectile( projectile )
	ProjectileManager:CreateLinearProjectile(info)
end

--------------------------------------------------------------------------------
-- Projectile events
function generic_projectile:OnProjectileLaunch( data )
	self:ProjectileLaunch( data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierProjectileLaunch( self, data )
	end
end

function generic_projectile:OnProjectileThink_ExtraData( location, data )
	self:ProjectileThink( location, data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierProjectileThink( self, location, data )
	end
end

function generic_projectile:OnProjectileHit_ExtraData( target, location, data )
	if data.pierce==1 then

		-- if there's target, projectile passes through it.
		-- if no target, the projectile ends.
		local ret = false

		if target then
			ret = self:ProjectileHit( target, location, data ) or ret
			for _,mod in pairs(self.modifiers) do
				ret = mod:ModifierProjectileHit( self, target, location, data ) or ret
			end
		else
			ret = self:ProjectileEnd( target, location, data ) or ret
			for _,mod in pairs(self.modifiers) do
				ret = mod:ModifierProjectileEnd( self, target, location, data ) or ret
			end
		end
		return ret
	else

		-- if target, then projectile procs both Hit and End, End has target.
		-- if it returns false, then projectile pass through, find other target.
		-- if no target, it is disjointed and only End procs.
		-- and false first
		local ret = true
		local r

		if target then
			-- Edge Case Bounce:
			if data.prev_target and EntIndexToHScript( data.prev_target )==target then return false end

			r = self:ProjectileHit( target, location, data )
			r = r==nil or r
			ret = ret and r
			for _,mod in pairs(self.modifiers) do
				r = mod:ModifierProjectileHit( self, target, location, data )
				r = r==nil or r
				ret = ret and r
			end
		end
		if not ret then
			return ret
		end

		r = self:ProjectileEnd( target, location, data )
		r = r==nil or r
		ret = ret and r
		for _,mod in pairs(self.modifiers) do
			r = mod:ModifierProjectileEnd( self, target, location, data )
			r = r==nil or r
			ret = ret and r
		end

		return ret
	end
end

--------------------------------------------------------------------------------
-- Overridden functions
function generic_projectile:ProjectileLaunch( data ) end
function generic_projectile:ProjectileThink( loc, data ) end
function generic_projectile:ProjectileHit( target, loc, data ) end
function generic_projectile:ProjectileEnd( target, loc, data ) end

function generic_projectile:InstallBase() end
function generic_projectile:UninstallBase() end
function generic_projectile:ModifierInstall( this ) end
function generic_projectile:ModifierUninstall( this ) end

function generic_projectile:ModifierProjectileLaunch( this, data ) end
function generic_projectile:ModifierProjectileThink( this, loc, data ) end
function generic_projectile:ModifierProjectileHit( this, target, loc, data ) end
function generic_projectile:ModifierProjectileEnd( this, target, loc, data ) end

function generic_projectile:ModifierAreaStart( this, data ) end
function generic_projectile:ModifierAreaThink( this, loc, data ) end
function generic_projectile:ModifierAreaHit( this, target, loc, data ) end
function generic_projectile:ModifierAreaEnd( this, loc, data ) end

--------------------------------------------------------------------------------
-- Helper
function generic_projectile:ProcessProjectile( proj )
	local caster = self:GetCaster()

	local direction = Vector( proj.direction_x, proj.direction_y, 0 )

	-- projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = GetGroundPosition( Vector( proj.origin_x, proj.origin_y, 0 ), nil ),
	
		bDeleteOnHit = not proj.pierce,
	
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	
		EffectName = proj.name,
		fDistance = proj.distance,
		fStartRadius = proj.radius,
		fEndRadius = proj.radius,
		vVelocity = direction * proj.speed,

		ExtraData = proj,
	}

	return info
end

function generic_projectile:GetAbilitySpecialValue( ability, name )
	local kv = self.kv[ability]["AbilitySpecial"]

	local specials = {}
	for _,v in pairs(kv) do
		for a,b in pairs(v) do
			if a~="var_type" then
				specials[a] = b
			end
		end
	end

	return specials[name] or 0
end

--------------------------------------------------------------------------------
-- Bounce
--------------------------------------------------------------------------------
red_transistor_bounce = class(generic_projectile)
function red_transistor_bounce:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf"
	data.bounce = self:GetSpecialValueFor( "bounces" )
end

function red_transistor_bounce:ProjectileHit( target, loc, data )
	if data.prev_target and EntIndexToHScript( data.prev_target )==target then
		return false
	end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" ),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- bounce
	if data.bounce < 1 then return true end
	data.bounce = data.bounce-1

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		data.distance,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)
	if #enemies<2 then return true end

	-- find next target
	local next_target
	for _,enemy in pairs(enemies) do
		if enemy~=target then
			next_target = enemy
			break
		end
	end
	if not next_target then return true end

	-- set direction
	local direction = next_target:GetOrigin()-loc
	direction.z = 0
	direction = direction:Normalized()

	data.direction_x = direction.x
	data.direction_y = direction.y
	data.prev_target = target:entindex()

	local info = self:ProcessProjectile( data )
	info.vSpawnOrigin = loc
	ProjectileManager:CreateLinearProjectile(info)

	return true
end

-- modifiers
function red_transistor_bounce:ModifierProjectileLaunch( this, data )
	data.bounces = this:GetAbilitySpecialValue( "red_transistor_bounce", "modifier_bounces" )
end

function red_transistor_bounce:ModifierProjectileEnd( this, target, loc, data )
	if data.prev_target and EntIndexToHScript( data.prev_target )==target then
		return false
	end

	if data.bounces < 1 then return end
	data.bounces = data.bounces - 1

	if not target then
		if data.pierce~=1 then return end
		data.direction_x = -data.direction_x
		data.direction_y = -data.direction_y
	else
		-- find enemies
		local enemies = FindUnitsInRadius(
			this:GetCaster():GetTeamNumber(),	-- int, your team number
			target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			data.distance,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)
		if #enemies<1 then return true end

		-- find next target
		local next_target
		for _,enemy in pairs(enemies) do
			if enemy~=target then
				next_target = enemy
				break
			end
		end
		if not next_target then return true end

		-- set direction
		local direction = next_target:GetOrigin()-loc
		direction.z = 0
		direction = direction:Normalized()

		data.direction_x = direction.x
		data.direction_y = direction.y
		data.prev_target = target:entindex()
	end

	data.origin_x = loc.x
	data.origin_y = loc.y

	local info = this:ProcessProjectile( data )
	ProjectileManager:CreateLinearProjectile(info)
end

function red_transistor_bounce:ModifierAreaStart( this, data )
	-- if not data.bounces then return end
	-- if data.bounces < 1 then return end
	-- data.bounces = data.bounces - 1

	local loc = GetGroundPosition( Vector( data.center_x, data.center_y, 0 ), this:GetCaster() )
	data.bounces = this:GetAbilitySpecialValue( "red_transistor_bounce", "modifier_bounces" )

	local delay = 1
	data.duration = delay

	-- create thinker
	CreateModifierThinker(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_bounce_area", -- modifier name
		data, -- kv
		loc,
		this:GetCaster():GetTeamNumber(),
		false
	)
end

-- function red_transistor_bounce:ModifierAreaEnd( this, loc, data )
-- end

--------------------------------------------------------------------------------
-- Breach
--------------------------------------------------------------------------------
red_transistor_breach = class(generic_projectile)
function red_transistor_breach:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf"
end

function red_transistor_breach:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )
end

-- Modifiers
function red_transistor_breach:ModifierInstall( this )
	local castrange = 100

	local mod = this:GetCaster():AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_breach_castrange", -- modifier name
		{
			castrange = castrange,
		} -- kv
	)
end

function red_transistor_breach:ModifierUninstall( this )
	local mods = this:GetCaster():FindAllModifiersByName( "modifier_red_transistor_breach_castrange" )
	for _,mod in pairs(mods) do
		if (not mod:IsNull()) and mod:GetAbility()==this then
			mod:Destroy()
		end
	end
end


-- function red_transistor_breach:ModifierProjectileLaunch( this, data )
-- 	local bonus = this:GetAbilitySpecialValue( "red_transistor_breach", "modifier_range" )

-- 	data.distance = data.distance + bonus
-- end


--------------------------------------------------------------------------------
-- Crash
--------------------------------------------------------------------------------
red_transistor_crash = class(generic_projectile)
function red_transistor_crash:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf"
end

function red_transistor_crash:ProjectileHit( target, loc, data )
	-- local damage = self:GetSpecialValueFor( "damage" )
	-- local duration = self:GetSpecialValueFor( "duration" )
	local damage = 100
	local duration = 1

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- apply stun
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = duration } -- kv
	)
end

-- Modifiers
function red_transistor_crash:ModifierProjectileHit( this, target, loc, data )
	local duration = this:GetAbilitySpecialValue( "red_transistor_crash", "modifier_stun" )

	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = duration } -- kv
	)
end

function red_transistor_crash:ModifierAreaHit( this, target, loc, data )
	self:ModifierProjectileHit( this, target, loc, data )
end
--------------------------------------------------------------------------------
-- Flood
--------------------------------------------------------------------------------
red_transistor_flood = class(generic_projectile)
function red_transistor_flood:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_puck/puck_illusory_orb.vpcf"
end

function red_transistor_flood:ProjectileThink( loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local radius = self:GetSpecialValueFor( "radius" )

	-- apply damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage*0.03,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	-- ApplyDamage( damageTable )

	-- find units
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		loc,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage( damageTable )
	end
end

-- modifiers
function red_transistor_flood:ModifierProjectileThink( this, loc, data )
	local duration = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_duration" )
	local dps = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_dps" )
	-- local radius = this:GetAbilitySpecialValue( "red_transistor_flood", "radius" )
	local radius = 150
	local interval = 0.1

	-- get data
	local step = data.speed * 0.03
	local half = radius/2

	-- check distance
	local origin = Vector( data.origin_x, data.origin_y, 0 )
	local length = (loc-origin):Length2D()

	-- spawn every half radius
	if length - math.floor(length/half)*half < step then
		CreateModifierThinker(
			this:GetCaster(), -- player source
			this, -- ability source
			"modifier_red_transistor_flood_thinker", -- modifier name
			{
				duration = duration,
				dps = dps,
				radius = radius,
				interval = interval,
			}, -- kv
			loc,
			this:GetCaster():GetTeamNumber(),
			false
		)
	end
end

function red_transistor_flood:ModifierAreaEnd( this, loc, data )
	-- local duration = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_duration" )
	local duration = 5
	local dps = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_dps" )
	-- local radius = this:GetAbilitySpecialValue( "red_transistor_flood", "radius" )
	local radius = data.radius
	local interval = 0.1

	CreateModifierThinker(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_flood_thinker", -- modifier name
		{
			duration = duration,
			dps = dps,
			radius = radius,
			interval = interval,
		}, -- kv
		loc,
		this:GetCaster():GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------
-- Get
--------------------------------------------------------------------------------
red_transistor_get = class(generic_projectile)
function red_transistor_get:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
end

function red_transistor_get:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "duration" )
	local speed = self:GetSpecialValueFor( "get_speed" )

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- apply modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_get_pull", -- modifier name
		{
			duration = duration,
			speed = speed,
			target_x = data.origin_x,
			target_y = data.origin_y,
		} -- kv
	)
end

-- modifiers
function red_transistor_get:ModifierProjectileThink( this, loc, data )
	if data.pierce~=1 then return end

	local radius = 150
	local duration = 0.1
	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "get_speed" )

	local dir = Vector( data.direction_x, data.direction_y, 0 )
	local location = loc - dir*radius/2

	-- get enemies
	local enemies = FindUnitsInRadius(
		this:GetCaster():GetTeamNumber(),	-- int, your team number
		location,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- add pull
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			this:GetCaster(), -- player source
			this, -- ability source
			"modifier_red_transistor_get_pull", -- modifier name
			{
				duration = duration,
				speed = speed,
				target_x = loc.x,
				target_y = loc.y,
			} -- kv
		)
	end
end

function red_transistor_get:ModifierProjectileHit( this, target, loc, data )
	if data.pierce==1 then return end

	local radius = 150
	local duration = 0.1
	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "get_speed" )

	-- set target
	local origin = Vector( data.origin_x, data.origin_y, 0 )
	local direction = Vector( data.direction_x, data.direction_y, 0 )
	local point = origin + direction*data.distance

	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_get_pull", -- modifier name
		{
			duration = duration,
			speed = speed,
			target_x = point.x,
			target_y = point.y,
		} -- kv
	)
end

function red_transistor_get:ModifierAreaHit( this, target, loc, data )
	local duration = 0.1
	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "get_speed" )

	-- set target
	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_get_pull", -- modifier name
		{
			duration = duration,
			speed = speed,
			target_x = data.center_x,
			target_y = data.center_y,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Ping
--------------------------------------------------------------------------------
red_transistor_ping = class(generic_projectile)
function red_transistor_ping:OnToggle()
	if self:GetToggleState() then
		self:GetCaster():AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_red_transistor_ping_toggle", -- modifier name
			{} -- kv
		)
	else
		local mod = self:GetCaster():FindModifierByName( "modifier_red_transistor_ping_toggle" )
		if mod then mod:Destroy() end
	end
end

function red_transistor_ping:ResetToggleOnRespawn()
	return true
end

function red_transistor_ping:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
end

function red_transistor_ping:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )
end

-- modifiers
function red_transistor_ping:ModifierInstall( this )
	local cooldown = 50

	local mod = this:GetCaster():AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_ping_cooldown", -- modifier name
		{
			cooldown = cooldown,
		} -- kv
	)
end

function red_transistor_ping:ModifierUninstall( this )
	local mods = this:GetCaster():FindAllModifiersByName( "modifier_red_transistor_ping_cooldown" )
	for _,mod in pairs(mods) do
		if (not mod:IsNull()) and mod:GetAbility()==this then
			mod:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Purge
--------------------------------------------------------------------------------
red_transistor_purge = class(generic_projectile)
function red_transistor_purge:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf"
end

function red_transistor_purge:ProjectileHit( target, loc, data )
	local duration = self:GetSpecialValueFor( "duration" )
	local damage = self:GetSpecialValueFor( "damage" )
	local interval = self:GetSpecialValueFor( "interval" )

	-- apply modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_purge_debuff", -- modifier name
		{
			duration = duration,
			damage = damage,
			interval = interval,
		} -- kv
	)
end

-- modifiers
function red_transistor_purge:ModifierProjectileHit( this, target, loc, data )
	local duration = 4
	local damage = 50
	local interval = 1

	-- apply modifier
	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_purge_debuff", -- modifier name
		{
			duration = duration,
			damage = damage,
			interval = interval,
		} -- kv
	)
end

function red_transistor_purge:ModifierAreaHit( this, target, loc, data )
	self:ModifierProjectileHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Switch
--------------------------------------------------------------------------------
red_transistor_switch = class(generic_projectile)
function red_transistor_switch:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf"
end

function red_transistor_switch:ProjectileHit( target, loc, data )
	local duration = self:GetSpecialValueFor( "duration" )

	-- apply modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_switch_debuff", -- modifier name
		{ duration = duration } -- kv
	)
end

-- modifiers
function red_transistor_switch:ModifierProjectileHit( this, target, loc, data )
	local duration = 2

	-- apply modifier
	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_switch_debuff", -- modifier name
		{ duration = duration } -- kv
	)
end

function red_transistor_switch:ModifierAreaHit( this, target, loc, data )
	self:ModifierProjectileHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Empty and Locked
--------------------------------------------------------------------------------
red_transistor_empty_1 = class(generic_projectile)
red_transistor_empty_2 = class(generic_projectile)
red_transistor_empty_3 = class(generic_projectile)
red_transistor_empty_4 = class(generic_projectile)
red_transistor_locked_1 = class(generic_projectile)
red_transistor_locked_2 = class(generic_projectile)
red_transistor_locked_3 = class(generic_projectile)
red_transistor_locked_4 = class(generic_projectile)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Abilities list
--------------------------------------------------------------------------------

local abilities = {
	["red_transistor_empty"] = red_transistor_empty_1,
	["red_transistor_locked"] = red_transistor_locked_1,

	["red_transistor_bounce"] = red_transistor_bounce,
	["red_transistor_breach"] = red_transistor_breach,
	["red_transistor_crash"] = red_transistor_crash,
	["red_transistor_flood"] = red_transistor_flood,
	["red_transistor_get"] = red_transistor_get,
	["red_transistor_ping"] = red_transistor_ping,
	["red_transistor_purge"] = red_transistor_purge,
	["red_transistor_switch"] = red_transistor_switch,

	["red_transistor_cull"] = red_transistor_cull,
	["red_transistor_help"] = red_transistor_help,
	["red_transistor_jaunt"] = red_transistor_jaunt,
	["red_transistor_load"] = red_transistor_load,
	["red_transistor_mask"] = red_transistor_mask,
	["red_transistor_spark"] = red_transistor_spark,
	["red_transistor_tap"] = red_transistor_tap,
	["red_transistor_void"] = red_transistor_void,
}

local ability_index = {
	["red_transistor_empty"] = 0,

	["red_transistor_bounce"] = 1,
	["red_transistor_breach"] = 2,
	["red_transistor_crash"] = 3,
	["red_transistor_flood"] = 4,
	["red_transistor_get"] = 5,
	["red_transistor_ping"] = 6,
	["red_transistor_purge"] = 7,
	["red_transistor_switch"] = 8,

	["red_transistor_cull"] = 9,
	["red_transistor_help"] = 10,
	["red_transistor_jaunt"] = 11,
	["red_transistor_load"] = 12,
	["red_transistor_mask"] = 13,
	["red_transistor_spark"] = 14,
	["red_transistor_tap"] = 15,
	["red_transistor_void"] = 16,

	["red_transistor_locked"] = 17,	

	["red_transistor_empty_1"] = 0,
	["red_transistor_empty_2"] = 0,
	["red_transistor_empty_3"] = 0,
	["red_transistor_empty_4"] = 0,
	["red_transistor_locked_1"] = 17,	
	["red_transistor_locked_2"] = 17,	
	["red_transistor_locked_3"] = 17,	
	["red_transistor_locked_4"] = 17,	

	[0] = "red_transistor_empty",

	[1] = "red_transistor_bounce",
	[2] = "red_transistor_breach",
	[3] = "red_transistor_crash",
	[4] = "red_transistor_flood",
	[5] = "red_transistor_get",
	[6] = "red_transistor_ping",
	[7] = "red_transistor_purge",
	[8] = "red_transistor_switch",

	[9] = "red_transistor_cull",
	[10] = "red_transistor_help",
	[11] = "red_transistor_jaunt",
	[12] = "red_transistor_load",
	[13] = "red_transistor_mask",
	[14] = "red_transistor_spark",
	[15] = "red_transistor_tap",
	[16] = "red_transistor_void",

	[17] = "red_transistor_locked",
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Access
--------------------------------------------------------------------------------
red_transistor_access = class({})

--------------------------------------------------------------------------------
-- Init Abilities
function red_transistor_access:Spawn()
	if not IsServer() then return end
	self:SetLevel( 1 )

	-- get ability references
	self.abilities = abilities
	self.ability_index = ability_index
	self.kv = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
	for k,v in pairs(self.kv) do
		if not self.ability_index[k] then
			self.kv[k] = nil
		end
	end

	-- set initial states as locked
	self.list = {}
	for i=1,6 do
		self.list[i] = 17
	end

	-- set abilities levels as 0
	self.levels = {}
	for i=1,2 do
		self.levels[i] = 0
	end

	-- get slot handles
	self.slots = {}
	self.slots[1] = self:GetCaster():FindAbilityByName( "red_transistor_locked_1" )
	self.slots[2] = self:GetCaster():FindAbilityByName( "red_transistor_locked_2" )

	-- initialize abilities
	for _,ability in pairs(self.slots) do
		ability:Install( self, "red_transistor_locked", "red_transistor_locked" )
	end

	-- listen to event
	CustomGameEventManager:RegisterListener( "red_transistor_access", self.EventConfirm )

	-- print("Abilities2")
	-- for k,v in pairs(abilities2) do
	-- 	print("",k,v)
	-- end
end

--------------------------------------------------------------------------------
-- Listener
function red_transistor_access:EventUpgrade( ability )
	local level = ability:GetLevel()

	-- get slot
	local slot
	for i,abil in pairs(self.slots) do
		if abil==ability then
			slot = i
		end
	end

	-- update ref
	self.levels[slot] = ability:GetLevel()

	-- update list (ability upgrade means change Locked to Empty)
	local ctr = slot-1
	self.list[ ctr*3 + ability:GetLevel()] = 0

	-- update abilities
	if level==1 then
		-- create Empty ability
		local caster = ability:GetCaster()
		local empty = caster:AddAbility( "red_transistor_empty_" .. slot )

		-- update level			
		self.lock = true
		empty:SetLevel( self.levels[slot] )
		self.lock = false

		-- swap
		caster:SwapAbilities(
			empty:GetAbilityName(),
			ability:GetAbilityName(),
			true,
			false
		)

		-- Install
		empty:Install( self, "red_transistor_locked", "red_transistor_locked" )

		-- set reference
		self.slots[slot] = empty

		-- remove locked
		ability:Uninstall()
		caster:RemoveAbilityByHandle( ability )
	elseif level==2 then
		-- change locked upgrade to empty upgrade
		ability:Replace( self, "red_transistor_empty", nil )
	elseif level==3 then
		ability:Replace( self, nil, "red_transistor_empty" )
	end

	-- Refresh Panorama
	local caster = self:GetCaster()
	local data = {}
	CustomGameEventManager:Send_ServerToPlayer( caster:GetPlayerOwner(), "red_transistor_access", data )

	self:PrintStatus()
end

function red_transistor_access.EventConfirm( playerID, data )
	local self = EntIndexToHScript( tonumber(data.ability) )

	-- -- convert to list
	-- local function_data = data.data
	-- local temp = {}
	-- for k,v in pairs(function_data) do
	-- 	local temp2 = {}
	-- 	for l,m in pairs(v) do
	-- 		temp2[tonumber(l)] = m
	-- 	end
	-- 	temp[tonumber(k)] = temp2
	-- end

	local list = data.list

	-- Validation
	local valid = self:Validate( list )
	if not valid then
		-- fail
		return
	end

	-- -- update data
	-- self.data['slots'] = temp

	-- start cooldown
	self:StartCooldown( self:GetCooldown(-1) )

	-- update ability layout
	self:UpdateAbilities( list )

	-- update ability list
	self.list = list

	-- self:RefreshUpgrades()
	-- self:RefreshClient()
	
	-- Refresh Panorama
	local caster = self:GetCaster()
	CustomGameEventManager:Send_ServerToPlayer( caster:GetPlayerOwner(), "red_transistor_access", data )

	self:PrintStatus()
end

--------------------------------------------------------------------------------
-- Update UI
function red_transistor_access:UpdateAbilities( list )
	print("UpdateAbilities")
	local caster = self:GetCaster()

	-- Uninstall Upgrades
	for _,ability in pairs(self.slots) do
		ability:Uninstall()
	end

	-- Change ability layout
	local mark_for_deletion = {}
	for ctr=0,1 do
		-- layout is main-up1-up2-main-up1-...
		local slot = ctr+1
		local i = ctr*3 + 1
		local new_ability_index = list[i]
		local new_ability_name = self.ability_index[new_ability_index]
		local modifier1 = self.ability_index[list[i+1]]
		local modifier2 = self.ability_index[list[i+2]]
		print(i,"new_ability",self.ability_index[new_ability_index])

		-- Assume not locked nor empty
		if new_ability_index==17 then
		-- Locked ability
			-- Locked do not change anything. Reinstall.
			self.slots[slot]:Install( self, modifier1, modifier2 )

		elseif new_ability_index==0 then
		-- Empty ability

			if self.list[i]==0 then
				-- previously also empty. Reinstall.
				self.slots[slot]:Install( self, modifier1, modifier2 )
			else
				-- previously was ability
				local new_ability = caster:AddAbility( "red_transistor_empty_" .. slot )

				-- update level			
				self.lock = true
				new_ability:SetLevel( self.levels[slot] )
				self.lock = false

				-- get old one
				local old_ability = self.slots[slot]

				-- swap ability
				caster:SwapAbilities( 
					new_ability:GetAbilityName(),
					old_ability:GetAbilityName(),
					true,
					false
				)
				mark_for_deletion[old_ability] = true

				-- install upgrades
				new_ability:Install( self, modifier1, modifier2 )

				-- set references
				self.slots[slot] = new_ability
				
			end
		else
		-- not Locked or Empty

			-- find existing ability
			local new_ability = caster:FindAbilityByName( new_ability_name )
			if not new_ability then

				-- create new
				new_ability = caster:AddAbility( new_ability_name )
				self.lock = true
				new_ability:SetLevel( self.levels[slot] )
				self.lock = false

				-- get old one
				local old_ability = self.slots[slot]

				-- swap ability
				caster:SwapAbilities( 
					new_ability:GetAbilityName(),
					old_ability:GetAbilityName(),
					true,
					false
				)
				mark_for_deletion[old_ability] = true

				-- install upgrades
				new_ability:Install( self, modifier1, modifier2 )

				-- set references
				self.slots[slot] = new_ability
			else
				-- dont delete it
				mark_for_deletion[new_ability] = nil

				-- check on correct slot
				if self.slots[slot]==new_ability then
					-- show if hidden
					new_ability:SetHidden( false )

					-- install upgrades
					new_ability:Install( self, modifier1, modifier2 )
				else
					-- set level according to slot
					self.lock = true
					new_ability:SetLevel( self.levels[slot] )
					self.lock = false

					-- get old one (will not be to the left)
					local old_ability = self.slots[slot]
					local old_slot
					for i,v in pairs(self.slots) do
						if new_ability==v then
							old_slot = i
							break
						end
					end

					-- swap ability
					caster:SwapAbilities( 
						new_ability:GetAbilityName(),
						old_ability:GetAbilityName(),
						true,
						false
					)
					mark_for_deletion[old_ability] = true

					-- install upgrades
					new_ability:Install( self, modifier1, modifier2 )

					-- set references
					self.slots[slot] = new_ability
					if old_slot then
						self.slots[old_slot] = old_ability
					end
				end
			end
		end -- ability switch
	end -- ctr loop

	-- remove abilities marked as deleted
	for abil,_ in pairs(mark_for_deletion) do
		caster:RemoveAbilityByHandle( abil )
	end
end


--------------------------------------------------------------------------------
-- Helper
function red_transistor_access:Validate( list )
	local valid = true
	-- Assuming the length are the same
	local len1 = 0
	local len2 = 0
	for k,v in pairs(list) do
		len1 = len1+1
	end
	for k,v in pairs(self.list) do
		len2 = len2+1
	end

	if len1~=len2 then
		print("Invalid: Length is different:",len1)
		return false
	end

	-- Rule 1: Locked stays locked
	for i,v in pairs(list) do
		if self.list[i]==17 and v~=17 then
			valid = false
			break
		end
	end
	if not valid then
		print("Invalid: Tried to unlock locked.")
		return false
	end

	-- Rule 2: No duplicates, except Empty and Locked
	for i=1,5 do
		if list[i]~=0 and list[i]~=17 then
			for j=i+1,6 do
				if list[i]==list[j] then
					valid = false
					break
				end
			end
			if not valid then break end
		end
	end
	if not valid then
		print("Invalid: Duplicates.")
		return false
	end

	return valid
end

function red_transistor_access:PrintStatus()
	print("PRINTSTATUS-----------------------------------")
	print("list")
	for k,v in pairs(self.list) do
		print("",k,v,self.ability_index[v])
	end
	print("levels")
	for k,v in pairs(self.levels) do
		print("",k,v)
	end
	print("abilities")
	for i=0,10 do
		local abil = self:GetCaster():GetAbilityByIndex( i )
		local name
		if abil then name = abil:GetAbilityName() end
		print("",i,abil,name)
	end
end

--------------------------------------------------------------------------------
-- Spell Start
function red_transistor_access:OnSpellStart()
	local caster = self:GetCaster()

	-- CORRECT CONFIRM TEST
	local list = {}
	for i=1,6 do
		list[i] = RandomInt( 1, 8 )
		if self.list[i]==17 then list[i] = 17 end
	end

	self.c2 = self.c2 or 1
	self.c1 = self.c1 or 0
	self.c1 = self.c1+1
	if self.c1>16 then
		self.c1 = 1
		self.c2 = self.c2+1
	end
	if self.c2>16 then
		self.c2 = 1
	end

	list[1] = 1
	list[2] = self.c1
	list[3] = self.c2
	-- list[4] = 2

	print("TEST LIST")
	for k,v in pairs(list) do
		print("",k,v,self.ability_index[v])
	end

	local data = {}
	data.list = list
	data.ability = self:entindex()
	self.EventConfirm( self:GetCaster():GetPlayerOwnerID(), data )

	-- MOCK LIST
	print("MOCK LIST")
	local mocklist = {}
	local available = { 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 }

	-- set mains
	for i=0,1 do
		local idx = i*3+1
		local get = RandomInt( 1, #available )
		local ability = available[get]
		table.remove( available, get )
		mocklist[idx] = ability
	end
	-- set modifiers
	for i=1,6 do
		if i==1 or i==4 then
		else
			local get = RandomInt( 1, #available )
			local ability = available[get]
			table.remove( available, get )
			mocklist[i] = ability
		end
	end
	for k,v in pairs(mocklist) do
		print("",k,v,self.ability_index[v])
	end

end

