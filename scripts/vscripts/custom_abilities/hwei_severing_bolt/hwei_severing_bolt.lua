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
hwei_severing_bolt = class({})
LinkLuaModifier( "modifier_hwei_severing_bolt", "custom_abilities/hwei_severing_bolt/modifier_hwei_severing_bolt", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_severing_bolt:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
function hwei_severing_bolt:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_severing_bolt:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor( "delay" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hwei_severing_bolt", -- modifier name
		{ duration = delay }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end