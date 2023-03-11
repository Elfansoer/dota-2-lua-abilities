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
muerta_the_calling_lua = class({})
LinkLuaModifier( "modifier_generic_silenced_lua", "lua_abilities/generic/modifier_generic_silenced_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_muerta_the_calling_lua_thinker", "lua_abilities/muerta_the_calling_lua/modifier_muerta_the_calling_lua_thinker", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_muerta_the_calling_lua_slow", "lua_abilities/muerta_the_calling_lua/modifier_muerta_the_calling_lua_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function muerta_the_calling_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_muerta.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_aoe.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_impact.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_muerta/muerta_calling_reticule.vpcf", context )
end

function muerta_the_calling_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function muerta_the_calling_lua:CreateCustomIndicator( position, unit, behavior )
	-- references
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_calling_reticule.vpcf"

	-- get data
	local radius = self:GetSpecialValueFor( "radius" )

	-- create particle
	self.effect_indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_indicator, 1, Vector( radius, radius, radius ) )
	self:UpdateCustomIndicator( position, behavior )
end

function muerta_the_calling_lua:UpdateCustomIndicator( position, unit, behavior )
	-- update particle position
	ParticleManager:SetParticleControl( self.effect_indicator, 0, position )

	local radius = self:GetSpecialValueFor( "radius" )
	local num_revenants = self:GetSpecialValueFor( "num_revenants" )
	local hit_radius = self:GetSpecialValueFor( "hit_radius" )
	local revenant_radius = radius - hit_radius

	local cp_max_revenants = 8
	local cp_pos_start = 2
	local cp_alpha_start = 10
	for i=1,math.min(num_revenants,cp_max_revenants) do
		local angle = math.pi/2 + 2*math.pi/num_revenants * i
		local pos = position + Vector( math.cos( angle ), math.sin( angle ), 0 ) * revenant_radius
		ParticleManager:SetParticleControl( self.effect_indicator, cp_pos_start + (i-1), pos )
		ParticleManager:SetParticleControl( self.effect_indicator, cp_alpha_start + (i-1), Vector(1,0,0) )
	end
end

function muerta_the_calling_lua:DestroyCustomIndicator( position, unit, behavior )
	-- destroy particle
	ParticleManager:DestroyParticle( self.effect_indicator, false )
	ParticleManager:ReleaseParticleIndex( self.effect_indicator )
end

--------------------------------------------------------------------------------
-- Ability Start
function muerta_the_calling_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_muerta_the_calling_lua_thinker",
		{duration = duration},
		point,
		caster:GetTeamNumber(),
		false
	)

	EmitSoundOnLocationWithCaster(point, "Hero_Muerta.Revenants.Cast", caster)
end