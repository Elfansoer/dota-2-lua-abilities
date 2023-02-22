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
sally_quadruple_slash = class({})
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_quadruple_slash", "custom_abilities/sally_quadruple_slash/modifier_sally_quadruple_slash", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_quadruple_slash_buff", "custom_abilities/sally_quadruple_slash/modifier_sally_quadruple_slash_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_quadruple_slash_debuff", "custom_abilities/sally_quadruple_slash/modifier_sally_quadruple_slash_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
function sally_quadruple_slash:GetCastRange(location, target)
	return self:GetCaster():Script_GetAttackRange()
end

--------------------------------------------------------------------------------
-- Passive Modifier
function sally_quadruple_slash:GetIntrinsicModifierName()
	return "modifier_sally_quadruple_slash"
end

--------------------------------------------------------------------------------
-- Orb Effects
function sally_quadruple_slash:OnOrbFire( params )
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local modifier = caster:AddNewModifier(
		caster,
		self,
		"modifier_sally_quadruple_slash_buff",
		{}
	)
	modifier:Init( params.target )

	local intrinsic = caster:FindModifierByName("modifier_sally_quadruple_slash")
	intrinsic:RegisterAttack( params.record )
end

--------------------------------------------------------------------------------
-- Ability Start
function sally_quadruple_slash:OnSpellStart()
end