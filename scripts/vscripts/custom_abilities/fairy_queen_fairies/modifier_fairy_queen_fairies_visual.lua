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
modifier_fairy_queen_fairies_visual = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_fairies_visual:IsHidden()
	return true
end

function modifier_fairy_queen_fairies_visual:IsPurgable()
	return false
end

function modifier_fairy_queen_fairies_visual:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_fairies_visual:OnCreated( kv )
	if not IsServer() then return end
	-- get references
	self.radius = 150
	self.fairies_count = 3
	self.fairies = {}
	self.circle_pos = {}
	self.time_delta = 0.1

	-- init positions
	self.base_vector = Vector(self.radius,0,150)
	self.rotation = 0
	self.rotation_delta = 18

	-- init fairies
	for i=1,self.fairies_count do
		self.fairies[i] = fairy_visual:Init()
		self.fairies[i]:CreateFairy( self:GetParent() )
	end

	-- start interval
	self:StartIntervalThink( self.time_delta )

end

function modifier_fairy_queen_fairies_visual:OnRefresh( kv )
	
end

function modifier_fairy_queen_fairies_visual:OnRemoved()
end

function modifier_fairy_queen_fairies_visual:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_fairy_queen_fairies_visual:OnIntervalThink()
	-- calculate circular position
	for i=1,self.fairies_count do
		j = i-1

		local split = 360/self.fairies_count
		local origin = self:GetParent():GetOrigin()
		self.circle_pos[i] = RotatePosition( origin, QAngle( 0, self.rotation + j*split, 0 ), origin + self.base_vector )
	end

	-- reposition fairies
	for i=1,self.fairies_count do
		self.fairies[i]:UpdateFairy( self.circle_pos[i] )
	end

	-- add rotation
	self.rotation = self.rotation + self.rotation_delta
end

--------------------------------------------------------------------------------
-- Helper
function modifier_fairy_queen_fairies_visual:GetFairies( count )
	if count>self.fairies_count then count = self.fairies_count end

	-- retrieve fairies
	local ret = {}
	for i=1,count do
		ret[i] = self.fairies[self.fairies_count-i+1]
		self.fairies[self.fairies_count-i+1] = nil
	end

	-- reduce fairies count
	self.fairies_count = self.fairies_count - count

	return ret
end
function modifier_fairy_queen_fairies_visual:SetFairies( count )
	for i=1,count do
		if not self.fairies[i] then
			self.fairies[i] = fairy_visual:Init()
			self.fairies[i]:CreateFairy( self:GetParent() )
		end
	end

	-- set fairies count
	self.fairies_count = count
end

--------------------------------------------------------------------------------
-- Fairy Class
fairy_visual = {}
function fairy_visual:Init()
	local ret = {}
	for k,v in pairs(self) do
		ret[k] = v
	end

	return ret
end
function fairy_visual:CreateFairy( parent, pos )
	self.parent = parent

	-- create particle
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf"
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )

	-- setup data
	local init_pos = self.parent:GetOrigin() + Vector(0,0,1000)
	if pos then
		init_pos = pos
		ParticleManager:SetParticleControl( effect_cast, 0, init_pos )
	end

	-- change cp
	ParticleManager:SetParticleControl( effect_cast, 0, init_pos )
	ParticleManager:SetParticleControl( effect_cast, 1, init_pos )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector(400,0,0) )
	ParticleManager:SetParticleShouldCheckFoW( effect_cast, true )
	ParticleManager:SetParticleFoWProperties( effect_cast, 1, 1, 50 )

	-- store data
	self.particles = effect_cast
	self.old_pos = init_pos
	self.old_time = GameRules:GetGameTime()
end

function fairy_visual:UpdateFairy( pos, speed )
	local effect = self.particles
	local time = GameRules:GetGameTime()

	-- determine delta
	local delta = (pos - self.old_pos):Length2D()
	local time_delta = time-self.old_time

	-- set target
	ParticleManager:SetParticleControl( effect, 1, pos )

	-- set speed
	if speed then
		ParticleManager:SetParticleControl( effect, 2, Vector(speed,0,0) )
	elseif delta>1000 then
		-- reset particle
		ParticleManager:DestroyParticle( effect, false )
		ParticleManager:ReleaseParticleIndex( effect )
		self:CreateFairy( self.parent, pos )
	elseif time_delta~=0 then
		ParticleManager:SetParticleControl( effect, 2, Vector(delta/time_delta,0,0) )
	end

	self.old_pos = pos
	self.old_time = time
end

function fairy_visual:DestroyFairy()
	-- destroy particle
	ParticleManager:DestroyParticle( self.particles, false )
	ParticleManager:ReleaseParticleIndex( self.particles )

	-- destroy reference
	self.parent = nil
	self.particles = nil
	self.old_pos = nil
	self.old_time = nil
end