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
megumin_explosion = class({})
LinkLuaModifier( "modifier_megumin_explosion", "custom_abilities/megumin_explosion/modifier_megumin_explosion", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_megumin_explosion_thinker", "custom_abilities/megumin_explosion/modifier_megumin_explosion_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function megumin_explosion:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_megumin_explosion/megumin_explosion.vpcf", context )
end

function megumin_explosion:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

--------------------------------------------------------------------------------
-- Custom KV
function megumin_explosion:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

-- AOE Radius
function megumin_explosion:GetAOERadius()
	return self:GetSpecialValueFor( "yellow_radius" )
end

-- AOE Radius
function megumin_explosion:GetCastRange(vLocation, hTarget)
	return self:GetSpecialValueFor( "yellow_castrange" )
end

function megumin_explosion:GetManaCost( level )
	return self:GetSpecialValueFor( "blue_manacost_pct" )/100 * self:GetCaster():GetMaxMana()
end

--------------------------------------------------------------------------------
-- Passive Modifier
function megumin_explosion:GetIntrinsicModifierName()
	return "modifier_megumin_explosion"
end

--------------------------------------------------------------------------------
-- Ability Start
function megumin_explosion:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor( "red_delay" )

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_megumin_explosion_thinker",
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
	)
end