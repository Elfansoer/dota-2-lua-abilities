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
jakiro_macropyre_lua = class({})
LinkLuaModifier( "modifier_jakiro_macropyre_lua", "lua_abilities/jakiro_macropyre_lua/modifier_jakiro_macropyre_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_macropyre_lua_thinker", "lua_abilities/jakiro_macropyre_lua/modifier_jakiro_macropyre_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- Cast Range
function jakiro_macropyre_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_scepter" )
	end

	return self:GetSpecialValueFor( "cast_range" )
end

--------------------------------------------------------------------------------
-- Ability Start
function jakiro_macropyre_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- calculate direction
	local dir = point - caster:GetOrigin()
	dir.z = 0
	dir = dir:Normalized()

	-- get duration
	local duration = self:GetSpecialValueFor( "duration" )
	if caster:HasScepter() then
		duration = self:GetSpecialValueFor( "duration_scepter" )
	end

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_jakiro_macropyre_lua_thinker", -- modifier name
		{
			duration = duration,
			x = dir.x,
			y = dir.y,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)

	-- play effects
	local sound_cast = "Hero_Jakiro.Macropyre.Cast"
	EmitSoundOn( sound_cast, caster )
end