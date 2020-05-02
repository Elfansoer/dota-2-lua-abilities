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
jakiro_ice_path_lua = class({})
LinkLuaModifier( "modifier_jakiro_ice_path_lua", "lua_abilities/jakiro_ice_path_lua/modifier_jakiro_ice_path_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_ice_path_lua_thinker", "lua_abilities/jakiro_ice_path_lua/modifier_jakiro_ice_path_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function jakiro_ice_path_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- calculate direction
	local dir = point - caster:GetOrigin()
	dir.z = 0
	dir = dir:Normalized()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_jakiro_ice_path_lua_thinker", -- modifier name
		{
			x = dir.x,
			y = dir.y,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
end