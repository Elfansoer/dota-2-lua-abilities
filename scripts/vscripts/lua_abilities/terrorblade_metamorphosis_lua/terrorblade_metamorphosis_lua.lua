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
terrorblade_metamorphosis_lua = class({})
LinkLuaModifier( "modifier_terrorblade_metamorphosis_lua", "lua_abilities/terrorblade_metamorphosis_lua/modifier_terrorblade_metamorphosis_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_terrorblade_metamorphosis_lua_aura", "lua_abilities/terrorblade_metamorphosis_lua/modifier_terrorblade_metamorphosis_lua_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function terrorblade_metamorphosis_lua:Precache( context )
	PrecacheModel( "models/heroes/terrorblade/demon.vmdl", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_transform.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function terrorblade_metamorphosis_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_terrorblade_metamorphosis_lua_aura", -- modifier name
		{ duration = duration } -- kv
	)
end