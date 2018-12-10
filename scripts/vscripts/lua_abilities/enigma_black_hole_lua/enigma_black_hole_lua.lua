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
enigma_black_hole_lua = class({})
LinkLuaModifier( "modifier_enigma_black_hole_lua_thinker", "lua_abilities/enigma_black_hole_lua/modifier_enigma_black_hole_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enigma_black_hole_lua_debuff", "lua_abilities/enigma_black_hole_lua/modifier_enigma_black_hole_lua_debuff", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function enigma_black_hole_lua:GetAOERadius()
	return self:GetSpecialValueFor( "far_radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function enigma_black_hole_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- create thinker
	self.thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_enigma_black_hole_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
	self.thinker = self.thinker:FindModifierByName("modifier_enigma_black_hole_lua_thinker")
end

--------------------------------------------------------------------------------
-- Ability Channeling
function enigma_black_hole_lua:OnChannelFinish( bInterrupted )
	if self.thinker then
		self.thinker:Destroy()
	end
end