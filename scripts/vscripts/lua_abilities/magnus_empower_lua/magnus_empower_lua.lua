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
magnus_empower_lua = class({})
LinkLuaModifier( "modifier_magnus_empower_lua", "lua_abilities/magnus_empower_lua/modifier_magnus_empower_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function magnus_empower_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_empower.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_empower_cleave_effect.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_magnataur/magnataur_empower_cleave_hit.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function magnus_empower_lua:OnAbilityPhaseInterrupted()

end
function magnus_empower_lua:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function magnus_empower_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "empower_duration" )

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_magnus_empower_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Magnataur.Empower.Cast"
	local sound_target = "Hero_Magnataur.Empower.Target"
	EmitSoundOn( sound_cast, caster )
	EmitSoundOn( sound_target, target )
end