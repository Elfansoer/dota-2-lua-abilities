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
darkness_crusaders_strength = class({})
LinkLuaModifier( "modifier_darkness_crusaders_strength", "custom_abilities/darkness_crusaders_strength/modifier_darkness_crusaders_strength", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_darkness_crusaders_strength_buff", "custom_abilities/darkness_crusaders_strength/modifier_darkness_crusaders_strength_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function darkness_crusaders_strength:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_darkness_crusaders_strength.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_darkness_crusaders_strength/darkness_crusaders_strength.vpcf", context )
end

function darkness_crusaders_strength:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function darkness_crusaders_strength:GetIntrinsicModifierName()
	return "modifier_darkness_crusaders_strength"
end