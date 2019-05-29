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
dragon_knight_elder_dragon_form_lua = class({})
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_lua", "lua_abilities/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_lua_corrosive", "lua_abilities/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua_corrosive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_lua_frost", "lua_abilities/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua_frost", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function dragon_knight_elder_dragon_form_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dragon_knight_elder_dragon_form_lua", -- modifier name
		{ duration = duration } -- kv
	)
end