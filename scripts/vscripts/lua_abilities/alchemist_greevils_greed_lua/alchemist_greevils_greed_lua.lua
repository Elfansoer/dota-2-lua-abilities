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
alchemist_greevils_greed_lua = class({})
LinkLuaModifier( "modifier_alchemist_greevils_greed_lua", "lua_abilities/alchemist_greevils_greed_lua/modifier_alchemist_greevils_greed_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_alchemist_greevils_greed_lua_stack", "lua_abilities/alchemist_greevils_greed_lua/modifier_alchemist_greevils_greed_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function alchemist_greevils_greed_lua:GetIntrinsicModifierName()
	return "modifier_alchemist_greevils_greed_lua"
end

-- --------------------------------------------------------------------------------
-- -- Ability Start
-- function alchemist_greevils_greed_lua:OnSpellStart()
-- 	-- unit identifier
-- 	local caster = self:GetCaster()
-- 	local target = self:GetCursorTarget()
-- 	local point = self:GetCursorPosition()

-- 	-- load data
-- 	local value1 = self:GetSpecialValueFor("some_value")

-- 	-- logic

-- end