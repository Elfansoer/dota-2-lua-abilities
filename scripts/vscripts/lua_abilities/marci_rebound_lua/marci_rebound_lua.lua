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
	if not IsServer() then return end
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

function marci_rebound_lua:CastFilterResultLocation( vLocation )

	-- store location cast
	self.pointcast = vLocation

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
	local target = self.targetcast
	local point = self.pointcast

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
