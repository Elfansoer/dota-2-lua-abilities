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
modifier_fairy_queen_whisk_visual = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_whisk_visual:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_whisk_visual:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.fairies = kv.fairies
	self.direction = Vector( kv.direction_x, kv.direction_y, kv.direction_z )
	local init_pos = self:GetParent():GetOrigin()
	self.particles = {}
	self.circle_pos = {}
	self.radius = 300
	self.time_delta = 0.1
	self.ally_radius = self:GetAbility():GetSpecialValueFor("ally_radius")
	self.enemy_radius = self:GetAbility():GetSpecialValueFor("enemy_radius")

	-- init positions
	self.base_vector = Vector(self.radius,0,100)
	self.height = 0
	self.height_delta = 200
	self.rotation = 0
	self.rotation_delta = 72

	-- init particles
	for i=1,self.fairies do
		local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
		ParticleManager:SetParticleControl( effect_cast, 0, init_pos )

		-- change cp
		ParticleManager:SetParticleControl( effect_cast, 1, init_pos )
		ParticleManager:SetParticleControl( effect_cast, 2, Vector(3000,0,0) )
		self.particles[i] = effect_cast
	end

	self:StartIntervalThink( 0.1 )

	-- Play effects
	self:PlayEffects()
end

function modifier_fairy_queen_whisk_visual:OnRefresh( kv )
	
end

function modifier_fairy_queen_whisk_visual:OnRemoved()
end

function modifier_fairy_queen_whisk_visual:OnDestroy()
	if not IsServer() then return end
	for i=1,self.fairies do
		ParticleManager:DestroyParticle( self.particles[i], false )
		ParticleManager:ReleaseParticleIndex( self.particles[i] )
	end
	UTIL_Remove(self:GetParent())
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_fairy_queen_whisk_visual:OnIntervalThink()
	-- calculate circular position
	for i=1,self.fairies do
		j = i-1

		local split = 360/self.fairies
		local origin = self:GetParent():GetOrigin()
		self.circle_pos[i] = RotatePosition( origin, QAngle( 0, self.rotation + j*split, 0 ), origin + self.base_vector ) + Vector(0,0,self.height)
	end
	self.rotation = self.rotation + self.rotation_delta
	-- self.height = self.height + self.height_delta

	-- reposition particles
	for i=1,self.fairies do
		ParticleManager:SetParticleControl( self.particles[i], 1, self.circle_pos[i] )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_fairy_queen_whisk_visual:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_ancient_seal_debuff_c.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	if self.fairies>1 then
		ParticleManager:SetParticleControl( effect_cast, 1, Vector(self.ally_radius + 100,0,0) )
	end
	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	if self.fairies<3 then return end

	-- Get Resources
	particle_cast = "particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_blinding_light_aoe.vpcf"

	-- Create Particle
	effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin()+self.direction )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector(self.enemy_radius,0,0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end
