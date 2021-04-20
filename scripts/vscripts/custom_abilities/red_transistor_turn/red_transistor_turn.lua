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
red_transistor_turn = class({})
LinkLuaModifier( "modifier_red_transistor_turn", "custom_abilities/red_transistor_turn/modifier_red_transistor_turn", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function red_transistor_turn:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_red_transistor.vsndevts", context )
	PrecacheResource( "particle", "particles/red_transistor_turn.vpcf", context )
	PrecacheResource( "particle", "particles/red_transistor_turn_projected.vpcf", context )
end

function red_transistor_turn:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function red_transistor_turn:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_turn", -- modifier name
		{ duration = duration } -- kv
	)
end