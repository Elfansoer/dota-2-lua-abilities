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
--[[
Issue:
	- Conflicts with other projectile changing abilities, such as Frost Arrows
]]
drow_ranger_marksmanship_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua", "lua_abilities/drow_ranger_marksmanship_lua/modifier_drow_ranger_marksmanship_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua_debuff", "lua_abilities/drow_ranger_marksmanship_lua/modifier_drow_ranger_marksmanship_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_drow_ranger_marksmanship_lua_effect", "lua_abilities/drow_ranger_marksmanship_lua/modifier_drow_ranger_marksmanship_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_marksmanship_lua:GetIntrinsicModifierName()
	return "modifier_drow_ranger_marksmanship_lua"
end

--------------------------------------------------------------------------------
-- Projectile
function drow_ranger_marksmanship_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	-- perform attack
	self.split = true
	self.split_procs = data.procs==1
	self:GetCaster():PerformAttack( target, true, true, true, false, false, false, false )
	self.split = false
end