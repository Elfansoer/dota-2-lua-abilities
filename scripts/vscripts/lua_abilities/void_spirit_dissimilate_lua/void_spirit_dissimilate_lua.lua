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
void_spirit_dissimilate_lua = class({})
LinkLuaModifier( "modifier_void_spirit_dissimilate_lua", "lua_abilities/void_spirit_dissimilate_lua/modifier_void_spirit_dissimilate_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function void_spirit_dissimilate_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "phase_duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_void_spirit_dissimilate_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play sound
	local sound_cast = "Hero_VoidSpirit.Dissimilate.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end