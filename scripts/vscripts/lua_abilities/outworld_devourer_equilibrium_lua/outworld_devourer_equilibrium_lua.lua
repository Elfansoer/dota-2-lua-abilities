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
outworld_devourer_equilibrium_lua = class({})
LinkLuaModifier( "modifier_outworld_devourer_equilibrium_lua", "lua_abilities/outworld_devourer_equilibrium_lua/modifier_outworld_devourer_equilibrium_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_outworld_devourer_equilibrium_lua_buff", "lua_abilities/outworld_devourer_equilibrium_lua/modifier_outworld_devourer_equilibrium_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_outworld_devourer_equilibrium_lua_debuff", "lua_abilities/outworld_devourer_equilibrium_lua/modifier_outworld_devourer_equilibrium_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function outworld_devourer_equilibrium_lua:GetIntrinsicModifierName()
	return "modifier_outworld_devourer_equilibrium_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function outworld_devourer_equilibrium_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add active buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_outworld_devourer_equilibrium_lua_buff", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_ObsidianDestroyer.Equilibrium.Cast"
	EmitSoundOn( sound_cast, caster )
end