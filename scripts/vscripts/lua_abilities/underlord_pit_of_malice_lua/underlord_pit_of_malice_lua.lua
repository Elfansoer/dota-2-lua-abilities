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
	-- create effects
	local point = self:GetCursorPosition()
	self:PlayEffects( point )

	return true -- if success
end
function underlord_pit_of_malice_lua:OnAbilityPhaseInterrupted()
	-- kill effect
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

end

--------------------------------------------------------------------------------
-- Ability Start
function underlord_pit_of_malice_lua:OnSpellStart()
	-- release cast effect
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

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
function underlord_pit_of_malice_lua:PlayEffects( point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice.Start"

	-- Get Data
	local radius = self:GetSpecialValueFor( "radius" )

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, point )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( radius, 1, 1 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationForAllies( point, sound_cast, self:GetCaster() )
end