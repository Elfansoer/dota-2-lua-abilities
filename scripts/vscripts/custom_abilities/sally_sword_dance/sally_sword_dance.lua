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
sally_sword_dance = class({})
LinkLuaModifier( "modifier_sally_sword_dance", "custom_abilities/sally_sword_dance/modifier_sally_sword_dance", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_sword_dance_active", "custom_abilities/sally_sword_dance/modifier_sally_sword_dance_active", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function sally_sword_dance:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sally_sword_dance.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_sally_sword_dance/sally_sword_dance.vpcf", context )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function sally_sword_dance:GetIntrinsicModifierName()
	return "modifier_sally_sword_dance"
end

--------------------------------------------------------------------------------
-- Ability Start
function sally_sword_dance:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "active_duration" )

	-- logic
	caster:AddNewModifier(
		caster,
		self,
		"modifier_sally_sword_dance_active",
		{duration = duration}
	)
end