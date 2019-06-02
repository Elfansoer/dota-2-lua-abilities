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
medusa_stone_gaze_lua = class({})
LinkLuaModifier( "modifier_medusa_stone_gaze_lua", "lua_abilities/medusa_stone_gaze_lua/modifier_medusa_stone_gaze_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_medusa_stone_gaze_lua_debuff", "lua_abilities/medusa_stone_gaze_lua/modifier_medusa_stone_gaze_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_medusa_stone_gaze_lua_petrified", "lua_abilities/medusa_stone_gaze_lua/modifier_medusa_stone_gaze_lua_petrified", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function medusa_stone_gaze_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_medusa_stone_gaze_lua", -- modifier name
		{ duration = duration } -- kv
	)
end