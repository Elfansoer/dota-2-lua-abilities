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
spirit_breaker_charge_of_darkness_lua = class({})
LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_lua", "lua_abilities/spirit_breaker_charge_of_darkness_lua/modifier_spirit_breaker_charge_of_darkness_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_spirit_breaker_charge_of_darkness_lua_debuff", "lua_abilities/spirit_breaker_charge_of_darkness_lua/modifier_spirit_breaker_charge_of_darkness_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Init Abilities
function spirit_breaker_charge_of_darkness_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_target.vpcf", context )
end

function spirit_breaker_charge_of_darkness_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function spirit_breaker_charge_of_darkness_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- add charge modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_spirit_breaker_charge_of_darkness_lua", -- modifier name
		{ target = target:entindex() } -- kv
	)
end