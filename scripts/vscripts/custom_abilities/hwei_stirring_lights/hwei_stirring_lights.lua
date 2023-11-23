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
hwei_stirring_lights = class({})
LinkLuaModifier( "modifier_hwei_stirring_lights", "custom_abilities/hwei_stirring_lights/modifier_hwei_stirring_lights", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hwei_stirring_lights:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hwei_stirring_lights/hwei_stirring_lights.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function hwei_stirring_lights:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_hwei_stirring_lights",
		{duration = duration}
	)
end