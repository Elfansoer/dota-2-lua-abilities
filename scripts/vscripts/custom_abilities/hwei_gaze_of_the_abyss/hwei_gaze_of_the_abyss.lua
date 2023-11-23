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
hwei_gaze_of_the_abyss = class({})
LinkLuaModifier( "modifier_hwei_gaze_of_the_abyss", "custom_abilities/hwei_gaze_of_the_abyss/modifier_hwei_gaze_of_the_abyss", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hwei_gaze_of_the_abyss_aura", "custom_abilities/hwei_gaze_of_the_abyss/modifier_hwei_gaze_of_the_abyss_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_gaze_of_the_abyss:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
function hwei_gaze_of_the_abyss:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_gaze_of_the_abyss:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor( "delay" )
	local duration = self:GetSpecialValueFor( "abyss_duration" ) + delay
	
	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hwei_gaze_of_the_abyss_aura", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end