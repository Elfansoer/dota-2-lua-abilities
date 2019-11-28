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
underlord_pit_of_malice_lua = class({})
LinkLuaModifier( "modifier_underlord_pit_of_malice_lua", "lua_abilities/underlord_pit_of_malice_lua/modifier_underlord_pit_of_malice_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_pit_of_malice_lua_cooldown", "lua_abilities/underlord_pit_of_malice_lua/modifier_underlord_pit_of_malice_lua_cooldown", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_pit_of_malice_lua_thinker", "lua_abilities/underlord_pit_of_malice_lua/modifier_underlord_pit_of_malice_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function underlord_pit_of_malice_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function underlord_pit_of_malice_lua:OnAbilityPhaseStart()
	return true -- if success
end
function underlord_pit_of_malice_lua:OnAbilityPhaseInterrupted()

end

--------------------------------------------------------------------------------
-- Ability Start
function underlord_pit_of_malice_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "pit_duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_underlord_pit_of_malice_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)

end
--------------------------------------------------------------------------------
-- Projectile
function underlord_pit_of_malice_lua:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
function underlord_pit_of_malice_lua:PlayEffects()
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