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
abaddon_aphotic_shield_lua = class({})
LinkLuaModifier( "modifier_abaddon_aphotic_shield_lua", "lua_abilities/abaddon_aphotic_shield_lua/modifier_abaddon_aphotic_shield_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function abaddon_aphotic_shield_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function abaddon_aphotic_shield_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- destroy old one
	local modifier = target:FindModifierByNameAndCaster( "modifier_abaddon_aphotic_shield_lua", caster)
	if modifier then
		modifier:Destroy()
	end

	-- add modifier
	target:AddNewModifier(
		caster,
		self,
		"modifier_abaddon_aphotic_shield_lua",
		{duration = duration}
	)

	-- purge
	target:Purge( false, true, false, true, true)
end