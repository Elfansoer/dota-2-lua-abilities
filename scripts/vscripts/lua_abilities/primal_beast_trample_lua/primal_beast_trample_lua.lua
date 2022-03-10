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
primal_beast_trample_lua = class({})
LinkLuaModifier( "modifier_primal_beast_trample_lua", "lua_abilities/primal_beast_trample_lua/modifier_primal_beast_trample_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function primal_beast_trample_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_trample.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function primal_beast_trample_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_trample_lua", -- modifier name
		{ duration = duration } -- kv
	)
end