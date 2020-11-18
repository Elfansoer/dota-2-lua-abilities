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
template = class({})
LinkLuaModifier( "modifier_template", "lua_abilities/template/modifier_template", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function template:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_template.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_template/template.vpcf", context )
end

function template:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function template:GetIntrinsicModifierName()
	return "modifier_template"
end

--------------------------------------------------------------------------------
-- Custom KV
function template:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

-- AOE Radius
function template:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function template:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function template:CastFilterResultTarget( hTarget )
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

	return UF_SUCCESS
end

function template:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end
--------------------------------------------------------------------------------
-- Ability Phase Start
function template:OnAbilityPhaseInterrupted()

end
function template:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function template:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local value1 = self:GetSpecialValueFor( "some_value" )

	-- logic

end
--------------------------------------------------------------------------------
-- Projectile
function template:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
-- Effects
function template:PlayEffects()
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
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end

--------------------------------------------------------------------------------
-- Ability Channeling
function template:GetChannelTime()

end

function template:OnChannelFinish( bInterrupted )

end

--------------------------------------------------------------------------------
-- Hero Events
function template:OnOwnerSpawned()

end

function template:OnOwnerDied()

end

function template:OnHeroLevelUp()

end

function template:OnHeroCalculateStatBonus()

end

--------------------------------------------------------------------------------
-- Ability Events
function template:OnUpgrade()

end

--------------------------------------------------------------------------------
-- Item Events
function template:OnInventoryContentsChanged()

end

function template:OnItemEquipped( item )

end

--------------------------------------------------------------------------------
-- Other Events
function template:OnHeroDiedNearby( unit, attacker, data )

end