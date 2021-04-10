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
modifier_dawnbreaker_celestial_hammer_lua_trail = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_celestial_hammer_lua_trail:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_celestial_hammer_lua_trail:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "flare_radius" )

	if not IsServer() then return end

	self.prev_pos = Vector( kv.x, kv.y, 0 )
	self.prev_pos = GetGroundPosition( self.prev_pos, self:GetParent() )

	-- play effects
	self:PlayEffects( kv.duration )
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:OnRefresh( kv )
	
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:OnRemoved()
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_dawnbreaker_celestial_hammer_lua_trail:IsAura()
	return true
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetModifierAura()
	return "modifier_dawnbreaker_celestial_hammer_lua_debuff"
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetAuraRadius()
	return self.radius
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetAuraDuration()
	return 0.5
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_dawnbreaker_celestial_hammer_lua_trail:GetAuraSearchFlags()
	return 0
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_celestial_hammer_lua_trail:PlayEffects( duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_burning_trail.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self.prev_pos )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end