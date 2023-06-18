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
darkness_vanguard = class({})
LinkLuaModifier( "modifier_darkness_vanguard", "custom_abilities/darkness_vanguard/modifier_darkness_vanguard", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function darkness_vanguard:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_darkness_vanguard.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_darkness_vanguard/darkness_vanguard.vpcf", context )
end

function darkness_vanguard:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

--------------------------------------------------------------------------------
-- Passive Modifier
function darkness_vanguard:GetIntrinsicModifierName()
	return "modifier_darkness_vanguard"
end