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

--[[
Not implemented:
- vertical motion unit bypass
- projectile obstruction

Shoud be revised:
- soldier still use "models/heroes/attachto_ghost/pa_gravestone_ghost.vmdl" as base class (also affects Spear of Mars)
]]
--------------------------------------------------------------------------------
mars_arena_of_blood_lua = class({})
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_mars_arena_of_blood_lua", "lua_abilities/mars_arena_of_blood_lua/modifier_mars_arena_of_blood_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_arena_of_blood_lua_blocker", "lua_abilities/mars_arena_of_blood_lua/modifier_mars_arena_of_blood_lua_blocker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_arena_of_blood_lua_thinker", "lua_abilities/mars_arena_of_blood_lua/modifier_mars_arena_of_blood_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_arena_of_blood_lua_wall_aura", "lua_abilities/mars_arena_of_blood_lua/modifier_mars_arena_of_blood_lua_wall_aura", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_mars_arena_of_blood_lua_spear_aura", "lua_abilities/mars_arena_of_blood_lua/modifier_mars_arena_of_blood_lua_spear_aura", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function mars_arena_of_blood_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function mars_arena_of_blood_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_mars_arena_of_blood_lua_thinker", -- modifier name
		{  }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end