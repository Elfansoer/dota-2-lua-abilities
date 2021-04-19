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
	- Breach castrange bonus does not affect GetCastRange
		help, mask, tap is duration, duration, radius
	- ping area hit is too good
	- Switch area modifier is unclear
- Test issues
	- Client/Panorama update should be broadcast to all client (minor)
	- enemy modifiers should have greyed out in panorama (minor)
- Improvements
	- Replace install uninstall by loop instead of hardcode name1 name2
	- set cast range as abilityspecial
	- "Modifier" to "Upgrade"
	- mark for deletion delayed by existing projectiles/buffs
- not in progress
	- help upgrade concept (illusion is not good)
- next
	breach castrange
	split access file to general projectile
	rework abilities
		crash vs cull, switch, get, ping
	delete after no refcount
	onstolen
	multiple same hero
]]

require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_base" )

--------------------------------------------------------------------------------
-- Game Modifiers
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
generic_projectile = class(generic_base)

--------------------------------------------------------------------------------
-- Ability Start
function generic_projectile:OnSpellStart()
	-- basic reference
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- get data
	local radius = self:GetSpecialValueFor( "radius" )
	local speed = self:GetSpecialValueFor( "speed" )
	local pierce = self:GetSpecialValueFor( "pierce" )

	-- direction
	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- unique projectile properties
	local projectile = {
		name = "projectile_name",
		distance = self:GetCastRange( point, nil ),
		radius = radius,
		speed = speed,
		pierce = pierce,
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

--------------------------------------------------------------------------------
-- Overridden functions
function generic_projectile:ProjectileLaunch( data ) end
function generic_projectile:ProjectileThink( loc, data ) end
function generic_projectile:ProjectileHit( target, loc, data ) end
function generic_projectile:ProjectileEnd( target, loc, data ) end

--------------------------------------------------------------------------------
-- Bounce
--[[
	radius, speed, pierce, damage
	active_bounces
	upgrade_bounces
	upgrade_delay
	passive_reflect
]]
--------------------------------------------------------------------------------
red_transistor_bounce = class(generic_projectile)
function red_transistor_bounce:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_mirana/mirana_spell_arrow.vpcf"
	data.bounce = self:GetSpecialValueFor( "active_bounces" )
end

function red_transistor_bounce:ProjectileHit( target, loc, data )
	if data.prev_target and EntIndexToHScript( data.prev_target )==target then
		return false
	end

	-- get data
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
	data.bounces = this:GetAbilitySpecialValue( "red_transistor_bounce", "upgrade_bounces" )
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
	data.bounces = this:GetAbilitySpecialValue( "red_transistor_bounce", "upgrade_bounces" )
	data.duration = this:GetAbilitySpecialValue( "red_transistor_bounce", "upgrade_delay" )

	local loc = GetGroundPosition( Vector( data.center_x, data.center_y, 0 ), this:GetCaster() )


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

--------------------------------------------------------------------------------
-- Breach
--[[
	radius, speed, pierce, damage
	active_range
	upgrade_castrange
	passive_bonus
]]
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
	local castrange = this:GetAbilitySpecialValue( "red_transistor_breach", "upgrade_castrange" )

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

function red_transistor_breach:ModifierProjectileLaunch( this, data )
	local bonus_pct = this:GetAbilitySpecialValue( "red_transistor_breach", "upgrade_castrange" )

	data.distance = data.distance + bonus_pct/100*data.distance
end

--------------------------------------------------------------------------------
-- Crash
--[[
	radius, speed, pierce, damage
	active_stun
	upgrade_stun
	passive_reduction
]]
--------------------------------------------------------------------------------
red_transistor_crash = class(generic_projectile)
function red_transistor_crash:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf"
end

function red_transistor_crash:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "active_stun" )
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
	local duration = this:GetAbilitySpecialValue( "red_transistor_crash", "upgrade_stun" )
	local duration = 0.5

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
--[[
	radius, speed, pierce, damage
	upgrade_duration
	upgrade_damage
	upgrade_radius
		upgrade_interval
	passive_bonus
]]
--------------------------------------------------------------------------------
red_transistor_flood = class(generic_projectile)
function red_transistor_flood:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_puck/puck_illusory_orb.vpcf"
end

function red_transistor_flood:ProjectileThink( loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local radius = self:GetSpecialValueFor( "radius" )
	local tick = damage * 0.03

	-- apply damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = tick,
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
	local duration = this:GetAbilitySpecialValue( "red_transistor_flood", "upgrade_duration" )
	local dps = this:GetAbilitySpecialValue( "red_transistor_flood", "upgrade_damage" )
	local radius = this:GetAbilitySpecialValue( "red_transistor_flood", "upgrade_radius" )
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
	local duration = this:GetAbilitySpecialValue( "red_transistor_flood", "upgrade_duration" )
	local dps = this:GetAbilitySpecialValue( "red_transistor_flood", "upgrade_damage" )
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
--[[
	radius, speed, pierce, damage
	active_speed
	active_duration
	upgrade_radius
	upgrade_duration
	passive_slow
	passive_duration
]]
--------------------------------------------------------------------------------
red_transistor_get = class(generic_projectile)
function red_transistor_get:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
end

function red_transistor_get:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "active_duration" )
	local speed = self:GetSpecialValueFor( "active_speed" )

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

	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "active_speed" )
	local radius = this:GetAbilitySpecialValue( "red_transistor_get", "upgrade_radius" )
	local duration = this:GetAbilitySpecialValue( "red_transistor_get", "upgrade_duration" )

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

	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "active_speed" )
	local radius = this:GetAbilitySpecialValue( "red_transistor_get", "upgrade_radius" )
	local duration = this:GetAbilitySpecialValue( "red_transistor_get", "upgrade_duration" )

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
	local duration = this:GetAbilitySpecialValue( "red_transistor_get", "upgrade_duration" )
	local speed = this:GetAbilitySpecialValue( "red_transistor_get", "active_speed" )

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
--[[
	radius, speed, pierce, damage
	active_interval
	upgrade_cooldown
	passive_bonus
]]
--------------------------------------------------------------------------------
red_transistor_ping = class(generic_projectile)
function red_transistor_ping:OnToggle()
	local interval = self:GetSpecialValueFor( "active_interval" )

	if self:GetToggleState() then
		self:GetCaster():AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_red_transistor_ping_toggle", -- modifier name
			{ interval = interval } -- kv
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
	local cooldown = this:GetAbilitySpecialValue( "red_transistor_ping", "upgrade_cooldown" )

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
--[[
	radius, speed, pierce, damage
	active_duration
	active_interval
	upgrade_duration
	upgrade_damage
	passive_armor
	passive_duration
]]
--------------------------------------------------------------------------------
red_transistor_purge = class(generic_projectile)
function red_transistor_purge:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf"
end

function red_transistor_purge:ProjectileHit( target, loc, data )
	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "active_duration" )
	local interval = self:GetSpecialValueFor( "active_interval" )

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
	local damage = this:GetAbilitySpecialValue( "red_transistor_purge", "upgrade_damage" )
	local duration = this:GetAbilitySpecialValue( "red_transistor_purge", "upgrade_duration" )
	local interval = this:GetAbilitySpecialValue( "red_transistor_purge", "active_interval" )

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
--[[
	radius, speed, pierce, damage
	active_duration
	upgrade_duration
	passive_bonus
]]
--------------------------------------------------------------------------------
red_transistor_switch = class(generic_projectile)
function red_transistor_switch:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf"
end

function red_transistor_switch:ProjectileHit( target, loc, data )
	local duration = self:GetSpecialValueFor( "active_duration" )
	if target:IsRealHero() then
		duration = duration/5
	end

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
	local duration = this:GetAbilitySpecialValue( "red_transistor_switch", "upgrade_duration" )
	if target:IsRealHero() then
		duration = duration/5
	end

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