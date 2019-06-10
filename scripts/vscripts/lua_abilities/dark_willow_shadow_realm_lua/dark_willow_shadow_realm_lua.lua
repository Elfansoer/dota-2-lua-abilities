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
dark_willow_shadow_realm_lua = class({})
LinkLuaModifier( "modifier_dark_willow_shadow_realm_lua", "lua_abilities/dark_willow_shadow_realm_lua/modifier_dark_willow_shadow_realm_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_shadow_realm_lua_buff", "lua_abilities/dark_willow_shadow_realm_lua/modifier_dark_willow_shadow_realm_lua_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function dark_willow_shadow_realm_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dark_willow_shadow_realm_lua", -- modifier name
		{ duration = duration } -- kv
	)
end