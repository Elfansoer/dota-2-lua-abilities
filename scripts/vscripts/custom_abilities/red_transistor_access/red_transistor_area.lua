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
LinkLuaModifier( "modifier_red_transistor_help_unit", "custom_abilities/red_transistor_access/modifier_red_transistor_help_unit", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_jaunt_manacost", "custom_abilities/red_transistor_access/modifier_red_transistor_jaunt_manacost", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_load_unit", "custom_abilities/red_transistor_access/modifier_red_transistor_load_unit", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_mask_invisible", "custom_abilities/red_transistor_access/modifier_red_transistor_mask_invisible", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_tap_lifesteal", "custom_abilities/red_transistor_access/modifier_red_transistor_tap_lifesteal", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_void_amplify", "custom_abilities/red_transistor_access/modifier_red_transistor_void_amplify", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Base Area abilities
--------------------------------------------------------------------------------
generic_area = class(generic_base)
-- generic_area.modifiers = {}

--------------------------------------------------------------------------------
-- Ability Start
function generic_area:OnSpellStart()
	-- basic reference
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- unique area properties
	local area = {
		radius = self:GetSpecialValueFor( "radius" ),
		center_x = point.x,
		center_y = point.y,
		origin_x = caster:GetOrigin().x,
		origin_y = caster:GetOrigin().y,
	}

	-- call OnStart event
	self:OnAreaStart( area )

	-- explode
	self:ProcessArea( area )
end

--------------------------------------------------------------------------------
-- Projectile events
function generic_area:OnAreaStart( data )
	self:AreaStart( data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierAreaStart( self, data )
	end
end

function generic_area:OnAreaThink( location, data )
	self:AreaThink( location, data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierAreaThink( self, location, data )
	end
end

function generic_area:OnAreaHit( target, location, data )
	self:AreaHit( target, location, data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierAreaHit( self, target, location, data )
	end
end

function generic_area:OnAreaEnd( location, data )
	self:AreaEnd( location, data )
	for _,mod in pairs(self.modifiers) do
		mod:ModifierAreaEnd( self, location, data )
	end
end

--------------------------------------------------------------------------------
-- Helper
function generic_area:ProcessArea( area )
	local caster = self:GetCaster()
	local pos = GetGroundPosition( Vector( area.center_x, area.center_y, 0 ), caster )

	-- explode
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		pos,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		area.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- call OnHit event
		self:OnAreaHit( enemy, enemy:GetOrigin(), area )
	end

	-- call OnEnd event
	self:OnAreaEnd( pos, area )
end

--------------------------------------------------------------------------------
-- Overridden functions
function generic_area:AreaStart( data ) end
function generic_area:AreaThink( loc, data ) end
function generic_area:AreaHit( target, loc, data ) end
function generic_area:AreaEnd( loc, data ) end

--------------------------------------------------------------------------------
-- Cull
--------------------------------------------------------------------------------
red_transistor_cull = class(generic_area)
function red_transistor_cull:AreaHit( target, loc, data )
	local damage = 100
	local duration = 1
	local height = 500

	-- add knockback
	local knockback = target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			duration = duration,
			distance = 0,
			height = height,
			-- fix_end = true,
			fix_duration = true,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	knockback:SetEndCallback(function( interrupted )
		-- damage
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)
	end)
end

function red_transistor_cull:AreaEnd( loc, data )
	-- play effects
	local particle_cast = "particles/units/heroes/hero_kunkka/kunkka_spell_torrent_splash.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_cull:ModifierAreaHit( this, target, loc, data )
	local duration = 1
	local height = 500

	-- add knockback
	local knockback = target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			duration = duration,
			distance = 0,
			height = height,
			-- fix_end = true,
			fix_duration = true,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	knockback:SetEndCallback(function( interrupted )

	end)	
end

function red_transistor_cull:ModifierProjectileHit( this, target, loc, data )
	self:ModifierAreaHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Help
--------------------------------------------------------------------------------
red_transistor_help = class(generic_area)
function red_transistor_help:GetBehavior()
	if self.passive then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function red_transistor_help:OnSpellStart()
	local name = 'npc_dota_red_transistor_help'

	-- duration is relative to castrange (for breach)
	-- local duration = self:GetCastRange( Vector(0,0,0), self:GetCaster() )*0.01
	local radius = 150
	local duration = 10

	-- basic reference
	local caster = self:GetCaster()

	-- spawn unit
	if self.unit then
		self.unit:ForceKill( false )
		self.unit:RespawnUnit()
		FindClearSpaceForUnit( self.unit, caster:GetOrigin(), true )

		self.unit:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_red_transistor_help_unit", -- modifier name
			{
				duration = duration,
				radius = radius,
			} -- kv
		)
		return
	end

	-- create unit
	local unit = CreateUnitByName(
		name,
		caster:GetOrigin(),
		true,
		caster,
		caster:GetOwner(),
		caster:GetTeamNumber()
	)
	FindClearSpaceForUnit( unit, caster:GetOrigin(), true )
	unit:SetControllableByPlayer( caster:GetPlayerID(), false )
	unit:SetOwner( caster )
	unit:SetUnitCanRespawn( true )

	unit:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_help_unit", -- modifier name
		{
			duration = duration,
			radius = radius,
		} -- kv
	)

	self.unit = unit
end

function red_transistor_help:AreaHit( target, loc, data )
	local damage = 100
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_help:AreaEnd( loc, data )
	-- play effects
	local particle_cast = "particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( data.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_help:ModifierAreaHit( this, target, loc, data )
	local outgoing = -80
	local incoming = 400
	local duration = 3
	local caster = this:GetCaster()

	-- create illusion
	local illusions = CreateIllusions(
		caster, -- hOwner
		caster, -- hHeroToCopy
		{
			outgoing_damage = outgoing,
			incoming_damage = incoming,
			duration = duration,
		}, -- hModiiferKeys
		1, -- nNumIllusions
		72, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	local illusion = illusions[1]
	FindClearSpaceForUnit( illusion, target:GetOrigin(), true )
end

function red_transistor_help:ModifierProjectileHit( this, target, loc, data )
	self:ModifierAreaHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Jaunt
--------------------------------------------------------------------------------
red_transistor_jaunt = class(generic_area)
function red_transistor_jaunt:AreaHit( target, loc, data )
	local damage = 100

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_jaunt:AreaEnd( loc, data )
	local caster = self:GetCaster()

	-- teleport (with bounce edge case)
	local bounce = data.bounces or 1
	if bounce>0 then
		FindClearSpaceForUnit( caster, loc, true )
		ProjectileManager:ProjectileDodge( caster )
	end

	-- play effects
	local particle_cast = "particles/items3_fx/blink_overwhelming_burst.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( data.radius, data.radius, data.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_jaunt:ModifierInstall( this )
	local manacost = 50

	local mod = this:GetCaster():AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_jaunt_manacost", -- modifier name
		{
			manacost = manacost,
		} -- kv
	)
end

function red_transistor_jaunt:ModifierUninstall( this )
	local mods = this:GetCaster():FindAllModifiersByName( "modifier_red_transistor_jaunt_manacost" )
	for _,mod in pairs(mods) do
		if (not mod:IsNull()) and mod:GetAbility()==this then
			mod:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Load
--------------------------------------------------------------------------------
red_transistor_load = class(generic_area)
function red_transistor_load:OnSpellStart()
	local name = 'npc_dota_red_transistor_load'
	local radius = 300

	-- basic reference
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create unit
	local unit = CreateUnitByName(
		name,
		point,
		true,
		nil,
		nil,
		DOTA_TEAM_NOTEAM
	)
	FindClearSpaceForUnit( unit, point, true )

	unit:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_load_unit", -- modifier name
		{
			radius = radius,
		} -- kv
	)
end

function red_transistor_load:AreaHit( target, loc, data )
	local damage = 200

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_load:AreaEnd( loc, data )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, loc )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( data.radius, data.radius, data.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_load:ModifierAreaHit( this, target, loc, data )
	local radius = 150
	local damage = 100

	-- damage
	local damageTable = {
		-- victim = target,
		attacker = this:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = this, --Optional.
	}
	-- ApplyDamage(damageTable)

	local enemies = FindUnitsInRadius(
		this:GetCaster():GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )
	end
end

function red_transistor_load:ModifierProjectileHit( this, target, loc, data )
	self:ModifierAreaHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Mask
--------------------------------------------------------------------------------
red_transistor_mask = class(generic_area)
function red_transistor_mask:GetBehavior()
	if self.passive then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function red_transistor_mask:OnSpellStart()
	-- duration is relative to castrange
	-- local duration = self:GetCastRange( Vector(0,0,0), self:GetCaster() )*0.01
	local duration = 10
	local backstab = 150

	-- basic reference
	local caster = self:GetCaster()
	local point = caster:GetOrigin()

	-- add invis modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_mask_invisible", -- modifier name
		{
			duration = duration,
			backstab = backstab,
		} -- kv
	)

	-- unique area properties
	local area = {
		radius = self:GetSpecialValueFor( "radius" ),
		center_x = point.x,
		center_y = point.y,
		origin_x = caster:GetOrigin().x,
		origin_y = caster:GetOrigin().y,
	}

	-- call OnStart event
	self:OnAreaStart( area )

	-- explode
	local enemies = self:ProcessArea( area )

	-- for _,enemy in pairs(enemies) do
	-- 	-- call OnHit event
	-- 	self:OnAreaHit( enemy, enemy:GetOrigin(), area )
	-- end

	-- -- call OnEnd event
	-- local pos = GetGroundPosition( Vector( area.center_x, area.center_y, 0 ), caster )
	-- self:OnAreaEnd( pos, area )

end

function red_transistor_mask:AreaHit( target, loc, data )
	local damage = 100

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_mask:AreaEnd( loc, data )
	-- play effects
	local particle_cast = "particles/items2_fx/smoke_of_deceit.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( data.radius, data.radius, data.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_mask:ModifierAreaHit( this, target, loc, data )
	local damage = 150

	-- backstab works if not seen
	if target:CanEntityBeSeenByMyTeam( this:GetCaster() ) then return end

	local damageTable = {
		victim = target,
		attacker = this:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = this, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_mask:ModifierProjectileHit( this, target, loc, data )
	self:ModifierAreaHit( this, target, loc, data )
end

--------------------------------------------------------------------------------
-- Spark
--------------------------------------------------------------------------------
red_transistor_spark = class(generic_area)
-- function red_transistor_spark:OnSpellStart()
-- 	local radius = 500

-- 	-- basic reference
-- 	local caster = self:GetCaster()
-- 	local point = self:GetCursorPosition()

-- 	-- unique area properties
-- 	local area = {
-- 		radius = radius,
-- 		center_x = point.x,
-- 		center_y = point.y,
-- 		origin_x = caster:GetOrigin().x,
-- 		origin_y = caster:GetOrigin().y,
-- 	}

-- 	-- call OnStart event
-- 	self:OnAreaStart( area )

-- 	-- process projectile

-- end

function red_transistor_spark:ProcessArea( area )
	local caster = self:GetCaster()
	local pos = GetGroundPosition( Vector( area.center_x, area.center_y, 0 ), caster )

	local name = "particles/units/heroes/hero_windrunner/windrunner_spell_powershot.vpcf"
	local hit_radius = 100
	local count = 16
	local speed = 3000

	-- prepare projectiles
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = pos,
	
		bDeleteOnHit = true,
	
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	
		EffectName = name,
		fDistance = area.radius,
		fStartRadius = hit_radius,
		fEndRadius = hit_radius,
		-- vVelocity = projectile_direction * projectile_speed,
		ExtraData = area,
	}

	-- launch multiple at once
	local delta = 360/count
	for i=0,count-1 do
		local deg = math.rad(i*delta)
		local direction = Vector( math.cos(deg), math.sin(deg), 0 )

		info.vVelocity = direction*speed
		ProjectileManager:CreateLinearProjectile(info)
	end

	-- call OnEnd event
	self:OnAreaEnd( pos, area )
end

function red_transistor_spark:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	-- do area hit
	self:OnAreaHit( target, target:GetOrigin(), data )

	return true
end

function red_transistor_spark:AreaHit( target, location, data )
	-- damage
	local damage = 30

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

-- modifiers
function red_transistor_spark:ModifierProjectileLaunch( this, data )
	if data.spark==1 then return end

	local projectiles = 2
	local angle = 30
	local loop = { -1, 1 }

	for _,i in pairs(loop) do
		local newdata = self:ShallowCopy( data )
		local newdir = Vector( data.direction_x, data.direction_y, 0 )
		newdir = RotatePosition( Vector(0,0,0), QAngle( 0, angle*i, 0 ), newdir )
		newdata.direction_x = newdir.x
		newdata.direction_y = newdir.y
		newdata.spark = 1

		-- call launch event
		this:OnProjectileLaunch( newdata )

		local info = this:ProcessProjectile( newdata )
		ProjectileManager:CreateLinearProjectile( info )
	end
end

function red_transistor_spark:ModifierAreaStart( this, data )
	if data.spark==1 then return end

	local sparks = 2

	-- get front direction from center
	local center = Vector( data.center_x, data.center_y, 0 )
	local origin = Vector( data.origin_x, data.origin_y, 0 )
	local direction = (center-origin)
	if direction:Length2D()<0.01 then
		direction = this:GetCaster():GetForwardVector()
	else
		direction = direction:Normalized()
	end

	-- process new location
	local angle = 360/(sparks+1)
	for i=1,sparks do
		local newdata = self:ShallowCopy( data )
		newdir = RotatePosition( Vector(0,0,0), QAngle( 0, angle*i, 0 ), direction )

		local newcenter = center + newdir*0.5*data.radius
		newdata.center_x = newcenter.x
		newdata.center_y = newcenter.y
		newdata.spark = 1

		this:ProcessArea( newdata )
	end

	-- process original location
	local newcenter = center + direction*0.5*data.radius
	data.center_x = newcenter.x
	data.center_y = newcenter.y
	data.spark = 1
end

function red_transistor_spark:ShallowCopy( data )
	local new = {}
	for k,v in pairs(data) do
		new[k] = v
	end
	return new
end

--------------------------------------------------------------------------------
-- Tap
--------------------------------------------------------------------------------
red_transistor_tap = class(generic_area)
function red_transistor_tap:GetBehavior()
	if self.passive then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end

	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function red_transistor_tap:InstallBase()
	local lifesteal = 30

	self.lifesteal = self:GetCaster():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_tap_lifesteal", -- modifier name
		{
			lifesteal = lifesteal,
		} -- kv
	)
end

function red_transistor_tap:UninstallBase()
	if self.lifesteal and (not self.lifesteal:IsNull()) then
		self.lifesteal:Destroy()
	end
end


function red_transistor_tap:OnSpellStart()
	-- radius is relative to castrange
	local radius = self:GetCastRange( Vector(0,0,0), self:GetCaster() )
	-- local radius = 600
	
	-- edge case breach castrange
	local mods = self:GetCaster():FindAllModifiersByName( "modifier_red_transistor_breach_castrange" )
	for _,mod in pairs(mods) do
		if (not mod:IsNull()) and mod:GetAbility()==self then
			radius = radius + mod.range_pct/100*radius
		end
	end

	-- basic reference
	local caster = self:GetCaster()

	-- unique area properties
	local area = {
		radius = radius,
		-- radius = self:GetSpecialValueFor( "radius" ),
		center_x = caster:GetOrigin().x,
		center_y = caster:GetOrigin().y,
		origin_x = caster:GetOrigin().x,
		origin_y = caster:GetOrigin().y,
	}

	-- call OnStart event
	self:OnAreaStart( area )

	-- explode
	local enemies = self:ProcessArea( area )

	-- for _,enemy in pairs(enemies) do
	-- 	-- call OnHit event
	-- 	self:OnAreaHit( enemy, enemy:GetOrigin(), area )
	-- end

	-- -- call OnEnd event
	-- local pos = GetGroundPosition( Vector( area.center_x, area.center_y, 0 ), caster )
	-- self:OnAreaEnd( pos, area )
end

function red_transistor_tap:AreaHit( target, location, data )
	-- damage
	local damage = 100

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end

function red_transistor_tap:AreaEnd( loc, data )
	-- play effects
	local particle_cast = "particles/units/heroes/hero_dazzle/dazzle_weave.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( data.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector( 50, 175, 150 ) )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector( 1, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_tap:ModifierInstall( this )
	local lifesteal = 10

	local mod = this:GetCaster():AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_tap_lifesteal", -- modifier name
		{
			lifesteal = lifesteal,
		} -- kv
	)
end

function red_transistor_tap:ModifierUninstall( this )
	local mods = this:GetCaster():FindAllModifiersByName( "modifier_red_transistor_tap_lifesteal" )
	for _,mod in pairs(mods) do
		if (not mod:IsNull()) and mod:GetAbility()==this then
			mod:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
-- Void
--------------------------------------------------------------------------------
red_transistor_void = class(generic_area)
function red_transistor_void:AreaHit( target, loc, data )
	local duration = 6
	local amplify = 6
	local max_amplify = 18

	-- spell amp debuff
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_red_transistor_void_amplify", -- modifier name
		{
			duration = duration,
			amplify = amplify,
			max_amplify = max_amplify,
		} -- kv
	)
end

function red_transistor_void:AreaEnd( loc, data )
	-- play effects
	local particle_cast = "particles/units/heroes/hero_shadow_demon/shadow_demon_soul_catcher.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, loc )
	ParticleManager:SetParticleControl( effect_cast, 1, loc )
	ParticleManager:SetParticleControl( effect_cast, 2, loc )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( data.radius, data.radius, data.radius ) )
	ParticleManager:SetParticleControl( effect_cast, 4, loc )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- modifiers
function red_transistor_void:ModifierAreaHit( this, target, loc, data )
	local duration = 3
	local amplify = 3
	local max_amplify = 18

	-- knockback
	target:AddNewModifier(
		this:GetCaster(), -- player source
		this, -- ability source
		"modifier_red_transistor_void_amplify", -- modifier name
		{
			duration = duration,
			amplify = amplify,
			max_amplify = max_amplify,
		} -- kv
	)	
end

function red_transistor_void:ModifierProjectileHit( this, target, loc, data )
	self:ModifierAreaHit( this, target, loc, data )
end