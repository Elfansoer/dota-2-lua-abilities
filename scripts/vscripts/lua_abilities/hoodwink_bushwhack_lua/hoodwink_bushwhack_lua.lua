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
hoodwink_bushwhack_lua = class({})
LinkLuaModifier( "modifier_hoodwink_bushwhack_lua_thinker", "lua_abilities/hoodwink_bushwhack_lua/modifier_hoodwink_bushwhack_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_bushwhack_lua_debuff", "lua_abilities/hoodwink_bushwhack_lua/modifier_hoodwink_bushwhack_lua_debuff", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Init Abilities
function hoodwink_bushwhack_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_fail.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_projectile.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_target.vpcf", context )
	PrecacheResource( "particle", "particles/tree_fx/tree_simple_explosion.vpcf", context )
end

function hoodwink_bushwhack_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function hoodwink_bushwhack_lua:GetAOERadius()
	return self:GetSpecialValueFor( "trap_radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function hoodwink_bushwhack_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "projectile_speed" )

	-- calculate delay
	local delay = (point-caster:GetOrigin()):Length2D()/projectile_speed

	-- create thinker at location
	local target = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_bushwhack_lua_thinker", -- modifier name
		{
			duration = delay,
		}, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end