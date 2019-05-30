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
windranger_windrun_lua = class({})
LinkLuaModifier( "modifier_windranger_windrun_lua", "lua_abilities/windranger_windrun_lua/modifier_windranger_windrun_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_windranger_windrun_lua_debuff", "lua_abilities/windranger_windrun_lua/modifier_windranger_windrun_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function windranger_windrun_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_windranger_windrun_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	local sound_cast = "Ability.Windrun"
	EmitSoundOn( sound_cast, caster )
end