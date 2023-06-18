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
modifier_darkness_decoy = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_decoy:IsHidden()
	return false
end

function modifier_darkness_decoy:IsDebuff()
	return false
end

function modifier_darkness_decoy:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_decoy:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.damage_reduction = self:GetAbility():GetSpecialValueFor( "dmg_reduction" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	self:PlayEffects()
end

function modifier_darkness_decoy:OnRefresh( kv )
	-- references
	self.damage_reduction = self:GetAbility():GetSpecialValueFor( "dmg_reduction" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
end

function modifier_darkness_decoy:OnRemoved()
end

function modifier_darkness_decoy:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_decoy:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_darkness_decoy:GetModifierIncomingDamage_Percentage( params )
	return 	self.damage_reduction
end

function modifier_darkness_decoy:GetModifierProvidesFOWVision()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_darkness_decoy:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	return state
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_darkness_decoy:IsAura()
	return true
	-- return false
end

function modifier_darkness_decoy:GetModifierAura()
	return "modifier_darkness_decoy_debuff"
end

function modifier_darkness_decoy:GetAuraRadius()
	return self.radius
end

function modifier_darkness_decoy:GetAuraDuration()
	return 0.5
end

function modifier_darkness_decoy:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_darkness_decoy:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_darkness_decoy:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf"

	-- Get Data
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.effect_cast, 0, caster:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end