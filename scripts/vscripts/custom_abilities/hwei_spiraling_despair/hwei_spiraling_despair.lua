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
hwei_spiraling_despair = class({})
LinkLuaModifier( "modifier_hwei_spiraling_despair", "custom_abilities/hwei_spiraling_despair/modifier_hwei_spiraling_despair", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_spiraling_despair:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_razor/razor_plasmafield.vpcf", context )
end

--------------------------------------------------------------------------------
-- Custom KV
function hwei_spiraling_despair:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_spiraling_despair:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	target:AddNewModifier(
		caster,
		self,
		"modifier_hwei_spiraling_despair",
		{duration = duration}
	)
end