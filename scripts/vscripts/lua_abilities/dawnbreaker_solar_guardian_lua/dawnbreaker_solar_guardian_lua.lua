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
dawnbreaker_solar_guardian_lua = class({})
LinkLuaModifier( "modifier_dawnbreaker_solar_guardian_lua", "lua_abilities/dawnbreaker_solar_guardian_lua/modifier_dawnbreaker_solar_guardian_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dawnbreaker_solar_guardian_lua_leap", "lua_abilities/dawnbreaker_solar_guardian_lua/modifier_dawnbreaker_solar_guardian_lua_leap", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dawnbreaker_solar_guardian_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dawnbreaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_damage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_healing_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_airtime_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_solar_guardian_landing.vpcf", context )
end

function dawnbreaker_solar_guardian_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
-- NOTE: The whole Custom Indicator doesn't work because FindUnitsInRadius is server-only.
function dawnbreaker_solar_guardian_lua:CreateCustomIndicator()
	local particle_cast1 = "particles/ui_mouseactions/range_finder_tp_dest.vpcf"
	local particle_cast2 = "particles/ui_mouseactions/range_finder_aoe.vpcf"
	self.effect_cast1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	self.effect_cast2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
end

function dawnbreaker_solar_guardian_lua:UpdateCustomIndicator( loc )
	-- get data
	local origin = self:GetCaster():GetAbsOrigin()
	local radius = self:GetSpecialValueFor( "radius" )
	local offset = self:GetSpecialValueFor( "max_offset_distance" )

	-- find rargets
	local target, point = self:FindValidPoint( loc )

	ParticleManager:SetParticleControl( self.effect_cast1, 0, origin )
	ParticleManager:SetParticleControl( self.effect_cast1, 2, target:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast1, 3, Vector( offset, 1, 1 ) )
	ParticleManager:SetParticleControl( self.effect_cast1, 4, point )

	ParticleManager:SetParticleControl( self.effect_cast2, 2, point )
	ParticleManager:SetParticleControl( self.effect_cast2, 3, Vector( radius, 1, 1 ) )
end

function dawnbreaker_solar_guardian_lua:DestroyCustomIndicator()
	ParticleManager:DestroyParticle( self.effect_cast1, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast1 )

	ParticleManager:DestroyParticle( self.effect_cast2, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast2 )
end

function dawnbreaker_solar_guardian_lua:FindValidPoint( point )
	local caster = self:GetCaster()
	local offset = self:GetSpecialValueFor( "max_offset_distance" )

	-- find allies
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetAbsOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target = caster
	local distance = (caster:GetAbsOrigin()-point):Length2D()
	for _,ally in pairs(allies) do
		-- check if distance is closer
		local d = (ally:GetAbsOrigin()-point):Length2D()
		if d<distance then
			distance = d
			target = ally
		end
	end

	if distance<offset then
		return target,point
	end

	-- get offset
	local direction = point-target:GetAbsOrigin()
	direction.z = 0
	direction = direction:Normalized()

	point = target:GetAbsOrigin() + direction*offset
	point = GetGroundPosition( point, caster )
	return target,point
end

--------------------------------------------------------------------------------
-- Custom KV
function dawnbreaker_solar_guardian_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function dawnbreaker_solar_guardian_lua:CastFilterResultLocation( vLoc )
	if IsClient() then
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end

	-- check nohammer
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_lua_nohammer" ) then
		return UF_FAIL_CUSTOM
	end

	if not IsServer() then return end

	local caster = self:GetCaster()
	local buffer = 1200

	-- find allies
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		vLoc,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		1200,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #allies<1 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function dawnbreaker_solar_guardian_lua:GetCustomCastErrorLocation( vLoc )
	-- check nohammer
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_lua_nohammer" ) then
		return "#dota_hud_error_nohammer"
	end

	if not IsServer() then return "" end

	local caster = self:GetCaster()
	local buffer = 1200

	-- find allies
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		vLoc,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		1200,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #allies<1 then
		return "#dota_hud_error_no_hero_in_range"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function dawnbreaker_solar_guardian_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- get actual point
	local target,point = self:FindValidPoint( point )

	-- load data
	local channel = self:GetChannelTime()
	local leaptime = self:GetSpecialValueFor( "airtime_duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dawnbreaker_solar_guardian_lua", -- modifier name
		{
			duration = channel+leaptime,
			x = point.x,
			y = point.y,
		} -- kv
	)

	-- store point
	self.point = point
end

--------------------------------------------------------------------------------
-- Ability Channeling
function dawnbreaker_solar_guardian_lua:OnChannelFinish( interrupted )
	-- unit identifier
	local caster = self:GetCaster()

	if interrupted then
		local mod = caster:FindModifierByName( "modifier_dawnbreaker_solar_guardian_lua" )
		if mod and (not mod:IsNull()) then
			mod:Destroy()
		end
		return
	end

	-- load data
	local duration = self:GetSpecialValueFor( "airtime_duration" )

	-- add leap modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dawnbreaker_solar_guardian_lua_leap", -- modifier name
		{
			duration = duration,
			x = self.point.x,
			y = self.point.y,
		} -- kv
	)
end