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
marci_rebound_lua = class({})
LinkLuaModifier( "modifier_marci_rebound_lua", "lua_abilities/marci_rebound_lua/modifier_marci_rebound_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_marci_rebound_lua_buff", "lua_abilities/marci_rebound_lua/modifier_marci_rebound_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_marci_rebound_lua_debuff", "lua_abilities/marci_rebound_lua/modifier_marci_rebound_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function marci_rebound_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_charge_projectile.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_landing_zone.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_allymovespeed.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_rebound_bounce_impact_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_snapfire_slow.vpcf", context )
end

function marci_rebound_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function marci_rebound_lua:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function marci_rebound_lua:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "landing_radius" )

	-- primary cast unit
	self.client_vector_unit = unit or self:GetCaster()

	-- create particle
	local particle_cast1 = "particles/ui_mouseactions/range_finder_line_moving_dash.vpcf"
	self.indicator1 = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.indicator1, 6, Vector( 255, 255, 255 ) )
	
	local particle_cast2 = "particles/ui_mouseactions/range_finder_generic_aoe_nocenter.vpcf"
	self.indicator2 = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self.client_vector_unit )
	ParticleManager:SetParticleControl( self.indicator2, 3, Vector( radius, 0, 0 ) )

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function marci_rebound_lua:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "landing_radius" )
	local castrange = self:GetCastRange( position, unit )
	local min_range = self:GetSpecialValueFor( "min_jump_distance" )
	local max_range = self:GetSpecialValueFor( "max_jump_distance" )
	local vector_origin = self.client_vector_unit:GetAbsOrigin()

	-- get out of castrange midpoint
	local midpoint = caster:GetAbsOrigin()
	local direction = vector_origin - caster:GetAbsOrigin()
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()
	if distance > castrange then
		midpoint = vector_origin - direction * castrange
	end

	ParticleManager:SetParticleControl( self.indicator1, 1, midpoint )
	ParticleManager:SetParticleControl( self.indicator1, 2, vector_origin )

	-- min/max jump distance
	local jump_direction = position - vector_origin
	local jump_distance = jump_direction:Length2D()
	jump_direction.z = 0
	jump_direction = jump_direction:Normalized()

	local jump_position = vector_origin + jump_direction * math.max( min_range, math.min( jump_distance, max_range ) )
	
	ParticleManager:SetParticleControl( self.indicator2, 0, self.client_vector_unit:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.indicator2, 1, self.client_vector_unit:GetAbsOrigin() )
	ParticleManager:SetParticleControl( self.indicator2, 2, jump_position )
	ParticleManager:SetParticleControl( self.indicator2, 12, jump_position )
end

function marci_rebound_lua:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- destroy particle
	ParticleManager:DestroyParticle(self.indicator1, false)
	ParticleManager:DestroyParticle(self.indicator2, false)
	ParticleManager:ReleaseParticleIndex(self.indicator1)
	ParticleManager:ReleaseParticleIndex(self.indicator2)

	self.client_vector_unit  = nil
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function marci_rebound_lua:CastFilterResultTarget( hTarget )

	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	-- store target cast
	self.targetcast = hTarget

	return UF_SUCCESS
end

function marci_rebound_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function marci_rebound_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self.vector_position

	-- load data
	local speed = self:GetSpecialValueFor( "move_speed" )

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		-- EffectName = "particles/units/heroes/hero_chaos_knight/chaos_knight_chaos_bolt.vpcf",
		iMoveSpeed = speed,
		bDodgeable = true,
	}
	local proj = ProjectileManager:CreateTrackingProjectile(info)

	-- create movement modifier
	-- NOTE/RANT: WHAT THE HECK HAPPENED VOLVO!
	-- if I pass the proj variable as it is, the value changed on the modifier!!!!
	-- now I have to use tostring instead!
	-- WTH VOLVO!

	self.modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_marci_rebound_lua", -- modifier name
		{
			proj = tostring(proj),
			target = target:entindex(),
			point_x = point.x,
			point_y = point.y,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Projectile
function marci_rebound_lua:OnProjectileHit( target, location )
	-- remove modifier
	if not self.modifier:IsNull() then
		if not target then
			self.modifier.interrupted = true
		end
		self.modifier:Destroy()
	end
end
