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
modifier_hwei_pool_of_reflection_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_pool_of_reflection_aura:IsHidden()
	return false
end

function modifier_hwei_pool_of_reflection_aura:IsDebuff()
	return false
end

function modifier_hwei_pool_of_reflection_aura:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_pool_of_reflection_aura:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger" )

	if not IsServer() then return end

	self:PlayEffects()
	EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
end

function modifier_hwei_pool_of_reflection_aura:OnRefresh( kv )
	
end

function modifier_hwei_pool_of_reflection_aura:OnRemoved()
end

function modifier_hwei_pool_of_reflection_aura:OnDestroy()
	if not IsServer() then return end
	StopSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)

	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_hwei_pool_of_reflection_aura:IsAura()
	return true
end

function modifier_hwei_pool_of_reflection_aura:GetModifierAura()
	return "modifier_hwei_pool_of_reflection"
end

function modifier_hwei_pool_of_reflection_aura:GetAuraRadius()
	return self.radius
end

function modifier_hwei_pool_of_reflection_aura:GetAuraDuration()
	return self.linger
end

function modifier_hwei_pool_of_reflection_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_hwei_pool_of_reflection_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_pool_of_reflection_aura:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_acid_spray.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end