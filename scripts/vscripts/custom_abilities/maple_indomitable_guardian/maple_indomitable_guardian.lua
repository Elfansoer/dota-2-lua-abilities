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
maple_indomitable_guardian = class({})
LinkLuaModifier( "modifier_maple_indomitable_guardian", "custom_abilities/maple_indomitable_guardian/modifier_maple_indomitable_guardian", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_indomitable_guardian_buff", "custom_abilities/maple_indomitable_guardian/modifier_maple_indomitable_guardian_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function maple_indomitable_guardian:GetIntrinsicModifierName()
	return "modifier_maple_indomitable_guardian"
end