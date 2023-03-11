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
dawnbreaker_starbreaker_lua = class({})
LinkLuaModifier( "modifier_dawnbreaker_starbreaker_lua", "lua_abilities/dawnbreaker_starbreaker_lua/modifier_dawnbreaker_starbreaker_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_dawnbreaker_starbreaker_lua_slow", "lua_abilities/dawnbreaker_starbreaker_lua/modifier_dawnbreaker_starbreaker_lua_slow", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Init Abilities
function dawnbreaker_starbreaker_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dawnbreaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/hero_dawnbreaker_combo_strike_range_finder_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_sweep.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_fire_wreath_smash.vpcf", context )
end

function dawnbreaker_starbreaker_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function dawnbreaker_starbreaker_lua:CreateCustomIndicator( loc )
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/hero_dawnbreaker_combo_strike_range_finder_aoe.vpcf"
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	self:UpdateCustomIndicator( loc )
end

function dawnbreaker_starbreaker_lua:UpdateCustomIndicator( loc )
	-- get data
	local origin = self:GetCaster():GetAbsOrigin()
	local radius = self:GetSpecialValueFor( "smash_radius" )
	local speed = self:GetSpecialValueFor( "movement_speed" )
	local duration = self:GetSpecialValueFor( "duration" )
	local delta = self:GetSpecialValueFor( "smash_distance_from_hero" )
	local distance = speed * duration + delta

	-- get direction
	local direction = loc - origin
	direction.z = 0
	direction = direction:Normalized()

	ParticleManager:SetParticleControl( self.effect_cast, 0, origin )
	ParticleManager:SetParticleControl( self.effect_cast, 1, origin + direction*distance )
	ParticleManager:SetParticleControl( self.effect_cast, 6, Vector( radius, 0, 0 ) )
end

function dawnbreaker_starbreaker_lua:DestroyCustomIndicator()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function dawnbreaker_starbreaker_lua:CastFilterResultLocation( vLoc )
	-- check nohammer
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_lua_nohammer" ) then
		return UF_FAIL_CUSTOM
	end

	if not IsServer() then return end

	return UF_SUCCESS
end

function dawnbreaker_starbreaker_lua:GetCustomCastErrorLocation( vLoc )
	-- check nohammer
	if self:GetCaster():HasModifier( "modifier_dawnbreaker_celestial_hammer_lua_nohammer" ) then
		return "#dota_hud_error_nohammer"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function dawnbreaker_starbreaker_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- get direction
	local direction = point-caster:GetOrigin()
	if direction:Length2D()<1 then
		direction = caster:GetForwardVector()
	else
		direction.z = 0
		direction = direction:Normalized()
	end

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dawnbreaker_starbreaker_lua", -- modifier name
		{
			duration = duration,
			x = direction.x,
			y = direction.y,
		} -- kv
	)
end