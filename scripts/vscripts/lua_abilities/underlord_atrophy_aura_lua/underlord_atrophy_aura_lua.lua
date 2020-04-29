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
underlord_atrophy_aura_lua = class({})
LinkLuaModifier( "modifier_underlord_atrophy_aura_lua", "lua_abilities/underlord_atrophy_aura_lua/modifier_underlord_atrophy_aura_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_atrophy_aura_lua_debuff", "lua_abilities/underlord_atrophy_aura_lua/modifier_underlord_atrophy_aura_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_atrophy_aura_lua_stack", "lua_abilities/underlord_atrophy_aura_lua/modifier_underlord_atrophy_aura_lua_stack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_atrophy_aura_lua_permanent_stack", "lua_abilities/underlord_atrophy_aura_lua/modifier_underlord_atrophy_aura_lua_permanent_stack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_underlord_atrophy_aura_lua_scepter", "lua_abilities/underlord_atrophy_aura_lua/modifier_underlord_atrophy_aura_lua_scepter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
-- function underlord_atrophy_aura_lua:GetIntrinsicModifierName()
-- 	return "modifier_underlord_atrophy_aura_lua"
-- end

function underlord_atrophy_aura_lua:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
--------------------------------------------------------------------------------
-- Ability Start
function underlord_atrophy_aura_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_underlord_atrophy_aura_lua", -- modifier name
		{ duration = 15 } -- kv
	)
end