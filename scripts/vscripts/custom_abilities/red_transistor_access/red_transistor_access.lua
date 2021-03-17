-- Created by Elfansoer
--[[
- Check False/True piercing projectile
- Projectile Events
	Launch: Projectile launched
	Think: Projectile in flight
	Hit: Projectile hits target
	End: Piercing ended, Non-piercing hits target (same with ProjHit)
- Issues
	- Bounce behavior is wild
	- Flood DoT too high
]]

--------------------------------------------------------------------------------
-- Game Modifiers
LinkLuaModifier( "modifier_red_transistor_flood_thinker", "custom_abilities/red_transistor_access/modifier_red_transistor_flood_thinker", LUA_MODIFIER_MOTION_NONE )
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
	self.modifiers = {}
	self.kv = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )

end

--------------------------------------------------------------------------------
-- Install/Uninstall
function generic_projectile:Install( abilities, name1, name2 )
	if name1 then
		self.modifiers[1] = abilities[name1]
		self.modifiers[1]:InstallBase( self )
	end
	if name2 then
		self.modifiers[2] = abilities[name2]
		self.modifiers[2]:InstallBase( self )
	end
end

function generic_projectile:Uninstall()
	for _,modifier in pairs(self.modifiers) do
		modifier:UninstallBase( self )
	end

	self.modifiers = {}
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
	if data.pierce==1 and target then
		self:ProjectileHit( target, location, data )
		for _,mod in pairs(self.modifiers) do
			mod:ModifierProjectileHit( self, target, location, data )
		end
		return false
	end

	self:ProjectileEnd( target, location, data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierProjectileEnd( self, target, location, data )
	end

	return true
end

--------------------------------------------------------------------------------
-- Overridden functions
function generic_projectile:InstallBase( this ) end
function generic_projectile:UninstallBase( this ) end

function generic_projectile:ProjectileLaunch( data ) end
function generic_projectile:ProjectileThink( loc, data ) end
function generic_projectile:ProjectileHit( target, loc, data ) end
function generic_projectile:ProjectileEnd( target, loc, data ) end

function generic_projectile:ModifierProjectileLaunch( data ) end
function generic_projectile:ModifierProjectileThink( loc, data ) end
function generic_projectile:ModifierProjectileHit( target, loc, data ) end
function generic_projectile:ModifierProjectileEnd( target, loc, data ) end

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

function red_transistor_bounce:ProjectileEnd( target, loc, data )
	if not target then return true end

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
	if data.bounces < 1 then return end
	data.bounces = data.bounces - 1

	if not target then
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
	end

	data.origin_x = loc.x
	data.origin_y = loc.y

	local info = this:ProcessProjectile( data )
	ProjectileManager:CreateLinearProjectile(info)
end

--------------------------------------------------------------------------------
-- Breach
--------------------------------------------------------------------------------
red_transistor_breach = class(generic_projectile)
function red_transistor_breach:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf"
end

function red_transistor_breach:ProjectileHit( target, loc, data )
	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" ),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	return false
end

-- Modifiers
function red_transistor_breach:ModifierProjectileLaunch( this, data )
	data.distance = data.distance + this:GetAbilitySpecialValue( "red_transistor_breach", "modifier_range" )
end

--------------------------------------------------------------------------------
-- Crash
--------------------------------------------------------------------------------
red_transistor_crash = class(generic_projectile)
function red_transistor_crash:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf"
end

function red_transistor_crash:ProjectileHit( target, loc, data )
	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" ),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- apply stun
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = self:GetSpecialValueFor( "duration" ) } -- kv
	)
end

-- Modifiers
function red_transistor_crash:ModifierProjectileHit( this, target, loc, data )
	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = this:GetAbilitySpecialValue( "red_transistor_crash", "modifier_stun" ) } -- kv
	)
end

function red_transistor_crash:ModifierProjectileEnd( this, target, loc, data )
	if not target then return end
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
	-- apply damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" )*0.03,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	-- ApplyDamage( damageTable )

	-- find units
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		loc,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self:GetSpecialValueFor( "radius" ),	-- float, radius. or use FIND_UNITS_EVERYWHERE
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
	-- get pos steps
	local step = data.speed * 0.03

	local duration = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_duration" )
	local dps = this:GetAbilitySpecialValue( "red_transistor_flood", "modifier_dps" )
	local radius = this:GetAbilitySpecialValue( "red_transistor_flood", "radius" )
	local half = radius/2

	-- check distance
	local origin = Vector( data.origin_x, data.origin_y, 0 )
	local length = (loc-origin):Length2D()
	-- print("length",length,math.floor(length/half)*half)

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
			}, -- kv
			loc,
			this:GetCaster():GetTeamNumber(),
			false
		)
	end
end

--------------------------------------------------------------------------------
-- Get
--------------------------------------------------------------------------------
red_transistor_get = class(generic_projectile)
function red_transistor_get:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
end

function red_transistor_get:ProjectileEnd( target, loc, data )
	if not target then return end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" ),
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
			duration = self:GetSpecialValueFor( "duration" ),
			speed = self:GetSpecialValueFor( "get_speed" ),
			target_x = data.origin_x,
			target_y = data.origin_y,
		} -- kv
	)
end

-- modifiers
function red_transistor_get:ModifierProjectileThink( this, loc, data )

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

function red_transistor_ping:ProjectileEnd( target, loc, data )
	if not target then return end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor( "damage" ),
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )
end

-- modifiers
function red_transistor_ping:InstallBase( this )
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

function red_transistor_ping:UninstallBase( this )
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

function red_transistor_purge:ProjectileEnd( target, loc, data )
	if not target then return end

	-- apply modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_purge_debuff", -- modifier name
		{
			duration = self:GetSpecialValueFor( "duration" ),
			damage = self:GetSpecialValueFor( "damage" ),
			interval = self:GetSpecialValueFor( "interval" ),
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

function red_transistor_purge:ModifierProjectileEnd( this, target, loc, data )
	if not target then return end
	self:ModifierProjectileHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Switch
--------------------------------------------------------------------------------
red_transistor_switch = class(generic_projectile)
function red_transistor_switch:ProjectileLaunch( data )
	data.name = "particles/units/heroes/hero_grimstroke/grimstroke_darkartistry_proj.vpcf"
end

function red_transistor_switch:ProjectileEnd( target, loc, data )
	if not target then return end

	-- apply modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_switch_debuff", -- modifier name
		{ duration = self:GetSpecialValueFor( "duration" ) } -- kv
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

function red_transistor_switch:ModifierProjectileEnd( this, target, loc, data )
	if not target then return end
	self:ModifierProjectileHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Modifiers
--------------------------------------------------------------------------------

local abilities = {
	["red_transistor_bounce"] = red_transistor_bounce,
	["red_transistor_breach"] = red_transistor_breach,
	["red_transistor_crash"] = red_transistor_crash,
	["red_transistor_flood"] = red_transistor_flood,
	["red_transistor_get"] = red_transistor_get,
	["red_transistor_ping"] = red_transistor_ping,
	["red_transistor_purge"] = red_transistor_purge,
	["red_transistor_switch"] = red_transistor_switch,
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
	self.abilities = abilities
end

function red_transistor_access:OnSpellStart()

	local name1 = "red_transistor_flood"
	local name2 = "red_transistor_breach"
	local name3 = "red_transistor_get"
	-- local name3 = nil

	caster = self:GetCaster()

	local ability = caster:FindAbilityByName( name1 )
	if not ability then return end

	ability:Uninstall()
	ability:Install( self.abilities, name2, name3 )
	print("Should Installed")

	-- print("red_transistor_access")
	-- for k,v in pairs(abilities) do
	-- 	print(k,v)
	-- 	for a,b in pairs(v) do
	-- 		print("",a,b)
	-- 	end
	-- end
end
