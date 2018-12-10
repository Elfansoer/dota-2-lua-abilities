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
faceless_void_chronosphere_lua = class({})
LinkLuaModifier( "modifier_faceless_void_chronosphere_lua_thinker", "lua_abilities/faceless_void_chronosphere_lua/modifier_faceless_void_chronosphere_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_faceless_void_chronosphere_lua_effect", "lua_abilities/faceless_void_chronosphere_lua/modifier_faceless_void_chronosphere_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function faceless_void_chronosphere_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function faceless_void_chronosphere_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function faceless_void_chronosphere_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local vision = self:GetSpecialValueFor("vision_radius")

	-- create thinker
	self.thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_faceless_void_chronosphere_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
	self.thinker = self.thinker:FindModifierByName("modifier_faceless_void_chronosphere_lua_thinker")

	-- create fov
	AddFOWViewer( self:GetCaster():GetTeamNumber(), point, vision, duration, false)
end