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
razor_eye_of_the_storm_lua = class({})
LinkLuaModifier( "modifier_razor_eye_of_the_storm_lua", "lua_abilities/razor_eye_of_the_storm_lua/modifier_razor_eye_of_the_storm_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_razor_eye_of_the_storm_lua_debuff", "lua_abilities/razor_eye_of_the_storm_lua/modifier_razor_eye_of_the_storm_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function razor_eye_of_the_storm_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_razor/razor_eye_of_the_storm.vpcf", context )
end

function razor_eye_of_the_storm_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function razor_eye_of_the_storm_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_razor_eye_of_the_storm_lua", -- modifier name
		{ duration = duration } -- kv
	)
end