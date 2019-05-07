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
modifier_fairy_queen_enchantment_visual = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_enchantment_visual:IsHidden()
	return true
end

function modifier_fairy_queen_enchantment_visual:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_enchantment_visual:OnCreated( kv )
	if not IsServer() then return end
	-- get references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.fairies = kv.fairies
	self.particles = {}
	self.circle_pos = {}
	self.time_delta = 0.1

	-- init positions
	self.base_vector = Vector(self.radius,0,150)
	self.rotation = 0
	self.rotation_delta = 36

	-- init particles
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
	for i=1,self.fairies do
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
		ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin()+Vector(0,0,150) )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector(2000,0,0) )

		-- buff particle
		self:AddParticle(
			effect_cast,
			false, -- bDestroyImmediately
			false, -- bStatusEffect
			-1, -- iPriority
			false, -- bHeroEffect
			false -- bOverheadEffect
		)

		self.particles[i] = effect_cast
	end

	-- start interval
	self:StartIntervalThink( self.time_delta )

	-- effects
	self:PlayEffects()
end

function modifier_fairy_queen_enchantment_visual:OnRefresh( kv )
	
end

function modifier_fairy_queen_enchantment_visual:OnRemoved()
end

function modifier_fairy_queen_enchantment_visual:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_fairy_queen_enchantment_visual:OnIntervalThink()
	for i=1,self.fairies do
		j = i-1

		-- calculate circular position
		local split = 360/self.fairies
		local origin = self:GetParent():GetOrigin()
		local pos = RotatePosition( origin, QAngle( 0, self.rotation + j*split, 0 ), origin + self.base_vector )

		-- reposition particles
		ParticleManager:SetParticleControl( self.particles[i], 1, pos )
	end
	-- add rotation
	self.rotation = self.rotation + self.rotation_delta
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_fairy_queen_enchantment_visual:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient_a.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.radius,0,0) )

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