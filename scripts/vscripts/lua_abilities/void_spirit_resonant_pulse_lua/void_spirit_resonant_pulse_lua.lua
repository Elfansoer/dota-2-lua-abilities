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
void_spirit_resonant_pulse_lua = class({})
LinkLuaModifier( "modifier_generic_ring_lua", "lua_abilities/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_resonant_pulse_lua", "lua_abilities/void_spirit_resonant_pulse_lua/modifier_void_spirit_resonant_pulse_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function void_spirit_resonant_pulse_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "buff_duration" )

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_void_spirit_resonant_pulse_lua", -- modifier name
		{ duration = duration } -- kv
	)
end

--------------------------------------------------------------------------------
-- Projectile
function void_spirit_resonant_pulse_lua:OnProjectileHit( target, location )
	if not target then return end

	local modifier = target:FindModifierByNameAndCaster( "modifier_void_spirit_resonant_pulse_lua", self:GetCaster() )
	if not modifier then return end
	modifier:Absorb()
end