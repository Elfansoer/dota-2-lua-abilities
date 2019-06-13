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
outworld_devourer_astral_imprisonment_lua = class({})
LinkLuaModifier( "modifier_outworld_devourer_astral_imprisonment_lua", "lua_abilities/outworld_devourer_astral_imprisonment_lua/modifier_outworld_devourer_astral_imprisonment_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function outworld_devourer_astral_imprisonment_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor( "prison_duration" )

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_outworld_devourer_astral_imprisonment_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_ObsidianDestroyer.AstralImprisonment.Cast"
	EmitSoundOn( sound_cast, caster )
end