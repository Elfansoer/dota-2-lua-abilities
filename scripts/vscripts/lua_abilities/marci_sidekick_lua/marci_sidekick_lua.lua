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
marci_sidekick_lua = class({})
LinkLuaModifier( "modifier_marci_sidekick_lua", "lua_abilities/marci_sidekick_lua/modifier_marci_sidekick_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function marci_sidekick_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_marci/marci_sidekick_self_buff.vpcf", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_marci_sidekick.vpcf", context )
end

function marci_sidekick_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function marci_sidekick_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "buff_duration" )

	-- check secondary target
	if target==caster then
		-- find allies
		local allies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self:GetCastRange( target:GetOrigin(), target ),	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO,	-- int, type filter
			0,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- get nearest ally
		local closest = nil
		for _,ally in pairs(allies) do
			if ally~=caster then
				closest = ally
				break
			end
		end

		-- set target as closest (or nil if not found)
		target = closest
	end

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_marci_sidekick_lua", -- modifier name
		{ duration = duration } -- kv
	)

	if not target then return end
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_marci_sidekick_lua", -- modifier name
		{ duration = duration } -- kv
	)
end