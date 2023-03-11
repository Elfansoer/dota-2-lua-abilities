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
void_spirit_aether_remnant_lua = class({})
LinkLuaModifier( "modifier_void_spirit_aether_remnant_lua", "lua_abilities/void_spirit_aether_remnant_lua/modifier_void_spirit_aether_remnant_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_aether_remnant_lua_thinker", "lua_abilities/void_spirit_aether_remnant_lua/modifier_void_spirit_aether_remnant_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function void_spirit_aether_remnant_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function void_spirit_aether_remnant_lua:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function void_spirit_aether_remnant_lua:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()

	-- primary cast position
	self.client_vector_position = position or self:GetCaster():GetAbsOrigin()

	-- create particle
	local particle_cast = "particles/ui_mouseactions/range_finder_cone.vpcf"
	self.indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.indicator, 3, Vector( 125, 125, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 4, Vector( 0, 255, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 6, Vector( 1, 0, 0 ) )

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function void_spirit_aether_remnant_lua:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local range = self:GetSpecialValueFor( "remnant_watch_distance" )
	local origin_pos = self.client_vector_position

	local direction = position - origin_pos
	direction.z = 0
	direction = direction:Normalized()

	local end_pos = origin_pos + direction * range

	-- update particle
	ParticleManager:SetParticleControl( self.indicator, 1, origin_pos )
	ParticleManager:SetParticleControl( self.indicator, 2, end_pos )
end

function void_spirit_aether_remnant_lua:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end
	self.client_vector_position  = nil

	-- destroy particle
	ParticleManager:DestroyParticle(self.indicator, false)
	ParticleManager:ReleaseParticleIndex(self.indicator)
	self.indicator = nil
end

--------------------------------------------------------------------------------
-- Ability Start
function void_spirit_aether_remnant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector_point = self.vector_position

	local direction = vector_point - point
	direction.z = 0
	direction = direction:Normalized()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_void_spirit_aether_remnant_lua_thinker", -- modifier name
		{
			dir_x = direction.x,
			dir_y = direction.y,
		}, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Emit Sound
	local sound_cast = "Hero_VoidSpirit.AetherRemnant.Cast"
	EmitSoundOn( sound_cast, caster )
end