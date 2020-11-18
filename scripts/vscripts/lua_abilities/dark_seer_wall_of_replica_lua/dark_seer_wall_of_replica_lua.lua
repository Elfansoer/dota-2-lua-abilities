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
dark_seer_wall_of_replica_lua = class({})
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_thinker", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_debuff", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_seer_wall_of_replica_lua_illusion", "lua_abilities/dark_seer_wall_of_replica_lua/modifier_dark_seer_wall_of_replica_lua_illusion", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dark_seer_wall_of_replica_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_dark_seer_illusion.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function dark_seer_wall_of_replica_lua:OnAbilityPhaseInterrupted()
end

function dark_seer_wall_of_replica_lua:OnAbilityPhaseStart()
	-- Vector targeting
	if not self:CheckVectorTargetPosition() then return false end
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_seer_wall_of_replica_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local targets = self:GetVectorTargetPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_dark_seer_wall_of_replica_lua_thinker", -- modifier name
		{
			duration = duration,
			x = targets.direction.x,
			y = targets.direction.y,
		}, -- kv
		targets.init_pos,
		caster:GetTeamNumber(),
		false
	)
end