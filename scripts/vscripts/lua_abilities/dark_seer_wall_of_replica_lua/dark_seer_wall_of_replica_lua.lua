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
dark_seer_wall_of_replica_lua = class({})
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_thinker", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_debuff", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_illusion", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_illusion", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dark_seer_wall_of_replica_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_dark_seer_illusion.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", context )
end

function dark_seer_wall_of_replica_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function dark_seer_wall_of_replica_lua:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function dark_seer_wall_of_replica_lua:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	self.indicators = {}

	-- primary cast position
	self.client_vector_position = position or self:GetCaster():GetAbsOrigin()

	-- create particle
	local particle_cast = "particles/ui_mouseactions/range_finder_cone.vpcf"

	for i=1,2 do
		self.indicators[i] = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
		ParticleManager:SetParticleControl( self.indicators[i], 3, Vector( 125, 125, 0 ) )
		ParticleManager:SetParticleControl( self.indicators[i], 4, Vector( 0, 255, 0 ) )
		ParticleManager:SetParticleControl( self.indicators[i], 6, Vector( 1, 0, 0 ) )	
	end

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function dark_seer_wall_of_replica_lua:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local range = self:GetSpecialValueFor( "width" )/2
	local origin_pos = self.client_vector_position

	local direction = position - origin_pos
	direction.z = 0
	direction = direction:Normalized()

	local fx_direction = {}
	fx_direction[1] = direction
	fx_direction[2] = -direction

	for i=1,2 do
		local end_pos = origin_pos + fx_direction[i] * range

		-- update particle
		ParticleManager:SetParticleControl( self.indicators[i], 1, origin_pos )
		ParticleManager:SetParticleControl( self.indicators[i], 2, end_pos )
	end
end

function dark_seer_wall_of_replica_lua:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end
	self.client_vector_position = nil

	for i=1,2 do
		-- destroy particle
		ParticleManager:DestroyParticle(self.indicators[i], false)
		ParticleManager:ReleaseParticleIndex(self.indicators[i])
		self.indicators[i] = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_seer_wall_of_replica_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector_point = self.vector_position

	local direction = vector_point - point
	direction.z = 0
	direction = direction:Normalized()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_dark_seer_wall_of_replica_lua_thinker", -- modifier name
		{
			duration = duration,
			x = direction.x,
			y = direction.y,
		}, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end