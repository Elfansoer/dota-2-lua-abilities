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
darkness_decoy = class({})
LinkLuaModifier( "modifier_darkness_decoy", "custom_abilities/darkness_decoy/modifier_darkness_decoy", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_darkness_decoy_taunt", "custom_abilities/darkness_decoy/modifier_darkness_decoy_taunt", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_darkness_decoy_debuff", "custom_abilities/darkness_decoy/modifier_darkness_decoy_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function darkness_decoy:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_queenofpain.vsndevts", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_beserkers_call.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf", context )
end

function darkness_decoy:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function darkness_decoy:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "taunt_duration" )
	local buff_duration = self:GetSpecialValueFor( "buff_duration" )
	local radius = self:GetSpecialValueFor( "radius" )

	-- adds buff
	caster:AddNewModifier(
		caster,
		self,
		"modifier_darkness_decoy",
		{duration = buff_duration}
	)

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- adds debuff
		enemy:AddNewModifier(
			caster,
			self,
			"modifier_darkness_decoy_taunt",
			{duration = duration}
		)
	end

	self:PlayEffects( caster, caster:GetOrigin(), radius )
end

function darkness_decoy:PlayEffects( caster, origin, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
	local sound_cast = "Hero_QueenOfPain.ScreamOfPain"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius, radius, radius) )
	ParticleManager:DestroyParticle( effect_cast, false )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end