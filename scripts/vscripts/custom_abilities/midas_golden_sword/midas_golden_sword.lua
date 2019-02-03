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
midas_golden_sword = class({})
LinkLuaModifier( "modifier_midas_golden_sword", "custom_abilities/midas_golden_sword/modifier_midas_golden_sword", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_sword_debuff", "custom_abilities/midas_golden_sword/modifier_midas_golden_sword_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function midas_golden_sword:GetIntrinsicModifierName()
	return "modifier_midas_golden_sword"
end