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
hoodwink_scurry_lua = class({})
LinkLuaModifier( "modifier_hoodwink_scurry_lua", "lua_abilities/hoodwink_scurry_lua/modifier_hoodwink_scurry_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hoodwink_scurry_lua_buff", "lua_abilities/hoodwink_scurry_lua/modifier_hoodwink_scurry_lua_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function hoodwink_scurry_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_hoodwink/hoodwink_scurry.vpcf", context )
end

function hoodwink_scurry_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function hoodwink_scurry_lua:GetIntrinsicModifierName()
	return "modifier_hoodwink_scurry_lua"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function hoodwink_scurry_lua:CastFilterResult()
	if self:GetCaster():HasModifier( "modifier_hoodwink_scurry_lua_buff" ) then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function hoodwink_scurry_lua:GetCustomCastError()
	if self:GetCaster():HasModifier( "modifier_hoodwink_scurry_lua_buff" ) then
		return "#dota_hud_error_already_has_buff"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function hoodwink_scurry_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_hoodwink_scurry_lua_buff", -- modifier name
		{ duration = duration } -- kv
	)
end