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
hwei_pool_of_reflection = class({})
LinkLuaModifier( "modifier_hwei_pool_of_reflection", "custom_abilities/hwei_pool_of_reflection/modifier_hwei_pool_of_reflection", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hwei_pool_of_reflection_aura", "custom_abilities/hwei_pool_of_reflection/modifier_hwei_pool_of_reflection_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_pool_of_reflection:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
function hwei_pool_of_reflection:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_pool_of_reflection:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "pool_duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hwei_pool_of_reflection_aura", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end