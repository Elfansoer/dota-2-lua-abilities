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
venomancer_poison_nova_lua = class({})
LinkLuaModifier( "modifier_venomancer_poison_nova_lua", "lua_abilities/venomancer_poison_nova_lua/modifier_venomancer_poison_nova_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_ring_lua", "lua_abilities/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function venomancer_poison_nova_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "particle", "particles/status_fx/status_effect_poison_venomancer.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_venomancer/venomancer_poison_debuff_nova.vpcf", context )
end

function venomancer_poison_nova_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Custom KV
function venomancer_poison_nova_lua:GetCastRange( pos, target )
	return self:GetSpecialValueFor( "radius" )
end

function venomancer_poison_nova_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function venomancer_poison_nova_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	local speed = self:GetSpecialValueFor( "speed" )
	local start_radius = self:GetSpecialValueFor( "start_radius" )
	local end_radius = self:GetSpecialValueFor( "radius" )

	-- create ring
	local ring = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			start_radius = start_radius,
			end_radius = end_radius,
			speed = speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			IsCircle = 0,
		} -- kv
	)
	ring:SetCallback( function( enemy )
		-- add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_venomancer_poison_nova_lua", -- modifier name
			{ duration = duration } -- kv
		)

		-- play effects
		local sound_cast = "Hero_Venomancer.PoisonNovaImpact"
		EmitSoundOn( sound_cast, enemy )
	end)

	-- play effects
	self:PlayEffects( ring, speed )
end

--------------------------------------------------------------------------------
-- Effects
function venomancer_poison_nova_lua:PlayEffects( modifier, speed )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_venomancer/venomancer_poison_nova.vpcf"
	local sound_cast = "Hero_Venomancer.PoisonNova"

	-- get data
	local duration = 1

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( speed, duration, speed ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end