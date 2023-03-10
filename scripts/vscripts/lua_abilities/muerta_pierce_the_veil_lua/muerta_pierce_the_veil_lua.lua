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
muerta_pierce_the_veil_lua = class({})
LinkLuaModifier( "modifier_muerta_pierce_the_veil_lua", "lua_abilities/muerta_pierce_the_veil_lua/modifier_muerta_pierce_the_veil_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_muerta_pierce_the_veil_lua_undisarm", "lua_abilities/muerta_pierce_the_veil_lua/modifier_muerta_pierce_the_veil_lua_undisarm", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function muerta_pierce_the_veil_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context )
	PrecacheResource( "model", "models/heroes/muerta/muerta_ult.vmdl", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_form_finish.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_form_screen_effect.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf", context )
end

function muerta_pierce_the_veil_lua:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_4
end

--------------------------------------------------------------------------------
-- Ability Start
function muerta_pierce_the_veil_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	local transform_duration = self:GetSpecialValueFor( "transform_duration" )

	-- purge & dodge
	caster:Purge(false, true, false, false, false)
	ProjectileManager:ProjectileDodge( caster )

	-- add modifier
	caster:AddNewModifier(
		caster,
		self,
		"modifier_muerta_pierce_the_veil_lua",
		{duration = duration + transform_duration}
	)

	EmitSoundOn( "Hero_Muerta.PierceTheVeil.Cast", caster )
end