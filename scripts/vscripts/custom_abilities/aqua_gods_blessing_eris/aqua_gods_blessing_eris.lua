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
aqua_gods_blessing_eris = class({})
LinkLuaModifier( "modifier_aqua_gods_blessing_eris", "custom_abilities/aqua_gods_blessing_eris/modifier_aqua_gods_blessing_eris", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function aqua_gods_blessing_eris:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_aqua_gods_blessing_eris.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_aqua_gods_blessing_eris/aqua_gods_blessing_eris.vpcf", context )
end

function aqua_gods_blessing_eris:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function aqua_gods_blessing_eris:CastFilterResultTarget( hTarget )
	if hTarget:GetUnitName() == "npc_dota_hero_aqua" then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function aqua_gods_blessing_eris:GetCustomCastErrorTarget( hTarget )
	if hTarget:GetUnitName() == "npc_dota_hero_aqua" then
		-- return "No, I wont bless Aqua-senpai. She's so mean to me."
		return "#dota_hud_error_cant_cast_on_aqua"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function aqua_gods_blessing_eris:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create modifier
	target:AddNewModifier(
		caster,
		self,
		"modifier_aqua_gods_blessing_eris",
		{duration = duration}
	)
end