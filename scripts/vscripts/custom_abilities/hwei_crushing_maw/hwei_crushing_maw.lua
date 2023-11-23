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
hwei_crushing_maw = class({})
LinkLuaModifier( "modifier_hwei_crushing_maw", "custom_abilities/hwei_crushing_maw/modifier_hwei_crushing_maw", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hwei_crushing_maw_debuff", "custom_abilities/hwei_crushing_maw/modifier_hwei_crushing_maw_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_crushing_maw:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_crushing_maw:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor( "delay" )
	local delay = 0.3
	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hwei_crushing_maw", -- modifier name
		{ duration = delay }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	):SetForwardVector( direction )

	-- create linear projectiles for effect
	-- TODO: change into proper effects
	local info1 = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = point - direction * self:GetSpecialValueFor( "width" ),
	
		bDeleteOnHit = false,
	
		EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		fDistance = self:GetSpecialValueFor( "width" )*2,
		fStartRadius = 50,
		fEndRadius = 50,
		vVelocity = direction * (self:GetSpecialValueFor( "width" )*2)/delay,
	}
	ProjectileManager:CreateLinearProjectile( info1 )

	direction = RotatePosition( Vector(0,0,0), QAngle( 0, 90, 0 ), direction )
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = point,
	
		bDeleteOnHit = false,
	
		EffectName = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf",
		fDistance = self:GetSpecialValueFor( "length" )-200,
		fStartRadius = self:GetSpecialValueFor( "width" ),
		fEndRadius = self:GetSpecialValueFor( "width" ),
		vVelocity = direction * (self:GetSpecialValueFor( "length" )-200)/delay,
	}
	ProjectileManager:CreateLinearProjectile( info )
	info.vVelocity = info.vVelocity * -1
	ProjectileManager:CreateLinearProjectile( info )
end