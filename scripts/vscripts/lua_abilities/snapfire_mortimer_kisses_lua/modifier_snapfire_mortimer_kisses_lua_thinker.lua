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
modifier_snapfire_mortimer_kisses_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications

--------------------------------------------------------------------------------
-- Initializations
function modifier_snapfire_mortimer_kisses_lua_thinker:OnCreated( kv )
	-- references
	self.max_travel = self:GetAbility():GetSpecialValueFor( "max_lob_travel_time" )
	self.radius = self:GetAbility():GetSpecialValueFor( "impact_radius" )
	self.linger = self:GetAbility():GetSpecialValueFor( "burn_linger_duration" )

	if not IsServer() then return end

	-- dont start aura right off
	self.start = false

	-- create aoe finder particle
	self:PlayEffects( kv.travel_time )
end

function modifier_snapfire_mortimer_kisses_lua_thinker:OnRefresh( kv )
	-- references
	self.max_travel = self:GetAbility():GetSpecialValueFor( "max_lob_travel_time" )
	self.radius = self:GetAbility():GetSpecialValueFor( "impact_radius" )
	self.linger = self:GetAbility():GetSpecialValueFor( "burn_linger_duration" )

	if not IsServer() then return end

	-- start aura
	self.start = true

	-- stop aoe finder particle
	self:StopEffects()
end

function modifier_snapfire_mortimer_kisses_lua_thinker:OnRemoved()
end

function modifier_snapfire_mortimer_kisses_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_snapfire_mortimer_kisses_lua_thinker:IsAura()
	return self.start
end

function modifier_snapfire_mortimer_kisses_lua_thinker:GetModifierAura()
	return "modifier_snapfire_mortimer_kisses_lua_debuff"
end

function modifier_snapfire_mortimer_kisses_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_snapfire_mortimer_kisses_lua_thinker:GetAuraDuration()
	return self.linger
end

function modifier_snapfire_mortimer_kisses_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_snapfire_mortimer_kisses_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_snapfire_mortimer_kisses_lua_thinker:PlayEffects( time )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius*(self.max_travel/time) ) )
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( time, 0, 0 ) )
end

function modifier_snapfire_mortimer_kisses_lua_thinker:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end