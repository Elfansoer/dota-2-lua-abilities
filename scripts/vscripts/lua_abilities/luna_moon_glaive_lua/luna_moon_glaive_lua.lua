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
Difference from original
- Each bounce is considered regular attacks (not spell)
- Works for melee
]]

luna_moon_glaive_lua = class({})
LinkLuaModifier( "modifier_luna_moon_glaive_lua", "lua_abilities/luna_moon_glaive_lua/modifier_luna_moon_glaive_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_luna_moon_glaive_lua_thinker", "lua_abilities/luna_moon_glaive_lua/modifier_luna_moon_glaive_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function luna_moon_glaive_lua:GetIntrinsicModifierName()
	return "modifier_luna_moon_glaive_lua"
end
