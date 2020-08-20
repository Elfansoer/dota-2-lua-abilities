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
dark_seer_ion_shell_lua = class({})
LinkLuaModifier( "modifier_dark_seer_ion_shell_lua", "lua_abilities/dark_seer_ion_shell_lua/modifier_dark_seer_ion_shell_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function dark_seer_ion_shell_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_seer_ion_shell_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dark_seer_ion_shell_lua", -- modifier name
		{ duration = duration } -- kv
	)
end