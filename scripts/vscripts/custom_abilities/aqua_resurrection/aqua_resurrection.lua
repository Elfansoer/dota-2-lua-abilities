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
aqua_resurrection = class({})
LinkLuaModifier( "modifier_aqua_resurrection", "custom_abilities/aqua_resurrection/modifier_aqua_resurrection", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_aqua_resurrection_thinker", "custom_abilities/aqua_resurrection/modifier_aqua_resurrection_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_aqua_resurrection_cooldown", "custom_abilities/aqua_resurrection/modifier_aqua_resurrection_cooldown", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function aqua_resurrection:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_aqua_resurrection.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_aqua_resurrection/aqua_resurrection.vpcf", context )
end

function aqua_resurrection:Spawn()
	if not IsServer() then return end
end

function aqua_resurrection:GetAbilityChargeRestoreTime( level )
	-- use AbilityCooldown kv as charge restore time
	return self.BaseClass.GetAbilityChargeRestoreTime( self, level )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function aqua_resurrection:GetIntrinsicModifierName()
	return "modifier_aqua_resurrection"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function aqua_resurrection:CastFilterResultLocation( vLocation )
	if not IsServer() then return UF_SUCCESS end

	local modifier = self:GetCaster():FindModifierByName( "modifier_aqua_resurrection" )
	if not modifier then return UF_FAIL_CUSTOM end

	local closest_tomb = modifier:FindClosestTomb( vLocation )
	if not closest_tomb then return UF_FAIL_CUSTOM end

	return UF_SUCCESS
end

function aqua_resurrection:GetCustomCastErrorLocation(vLocation)
	return "#dota_hud_error_cannot_find_tomb"
end

-- --------------------------------------------------------------------------------
-- -- Ability Phase Start
-- function aqua_resurrection:OnAbilityPhaseInterrupted()

-- end
-- function aqua_resurrection:OnAbilityPhaseStart()
-- 	return true -- if success
-- end

--------------------------------------------------------------------------------
-- Ability Start
function aqua_resurrection:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local modifier = caster:FindModifierByName( "modifier_aqua_resurrection" )
	if not modifier then return end

	local closest_tomb = modifier:FindClosestTomb( point )
	if not closest_tomb then return end

	local target_hero = modifier.tombs[closest_tomb]
	if (not target_hero:IsNull()) and not (target_hero:IsAlive()) then
		target_hero:RespawnHero( false, false )
		FindClearSpaceForUnit(target_hero, closest_tomb:GetParent():GetOrigin(), true)
		local invulnerable = target_hero:FindModifierByName( "modifier_fountain_invulnerability" )
		if invulnerable then
			invulnerable:Destroy()
		end
		target_hero:AddNewModifier(caster, self, "modifier_aqua_resurrection_cooldown", {})

		closest_tomb:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Effects
function aqua_resurrection:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlTransformForward( effect_cast, iControlPoint, vForward )
	SetParticleControlTransform( effect_cast, iControlPoint, origin, qangles )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end