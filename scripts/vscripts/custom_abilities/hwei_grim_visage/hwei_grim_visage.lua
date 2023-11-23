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
hwei_grim_visage = class({})
LinkLuaModifier( "modifier_hwei_grim_visage", "custom_abilities/hwei_grim_visage/modifier_hwei_grim_visage", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_grim_visage:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_vengefulspirit.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_grim_visage:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local effect_name = "particles/units/heroes/hero_muerta/muerta_deadshot_linear.vpcf"
	local distance = self:GetCastRange(point, nil)
	local width = self:GetSpecialValueFor( "width" )
	local speed = self:GetSpecialValueFor( "speed" )

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- linear projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetOrigin(),
		
		bDeleteOnHit = false,
		
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		
		EffectName = effect_name,
		fDistance = distance,
		fStartRadius = width,
		fEndRadius = width,
		vVelocity = direction * speed,
	
		bProvidesVision = true,
		iVisionRadius = width,
		iVisionTeamNumber = caster:GetTeamNumber(),

		ExtraData = {
			dir_x = direction.x,
			dir_y = direction.y,
		}
	}
	ProjectileManager:CreateLinearProjectile( info )

	EmitSoundOn( "Hero_VengefulSpirit.WaveOfTerror" , caster )
end

--------------------------------------------------------------------------------
-- Projectile
function hwei_grim_visage:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	local damage = self:GetSpecialValueFor( "damage" )
	local duration = self:GetSpecialValueFor( "duration" )

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage( damageTable )

	-- apply fear
	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_hwei_grim_visage",
		{ duration = duration }
	):Init( data )
end