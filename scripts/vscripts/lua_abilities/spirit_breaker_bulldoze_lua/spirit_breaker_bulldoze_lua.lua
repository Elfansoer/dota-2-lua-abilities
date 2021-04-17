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
spirit_breaker_bulldoze_lua = class({})
LinkLuaModifier( "modifier_spirit_breaker_bulldoze_lua", "lua_abilities/spirit_breaker_bulldoze_lua/modifier_spirit_breaker_bulldoze_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function spirit_breaker_bulldoze_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf", context )
end

function spirit_breaker_bulldoze_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function spirit_breaker_bulldoze_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_spirit_breaker_bulldoze_lua", -- modifier name
		{ duration = duration } -- kv
	)
end