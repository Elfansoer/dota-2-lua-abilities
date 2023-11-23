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
modifier_hwei_pool_of_reflection = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_pool_of_reflection:IsHidden()
	return false
end

function modifier_hwei_pool_of_reflection:IsDebuff()
	return false
end

function modifier_hwei_pool_of_reflection:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_pool_of_reflection:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.max_shield = self:GetAbility():GetSpecialValueFor( "initial_shield" )
	self.shield_per_second = self:GetAbility():GetSpecialValueFor( "shield_per_second" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger" )
	
	self.interval = 0.1
	self.current_shield = self.max_shield
	self.linger = self.linger - 0.1

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
	
	self:PlayEffectsStart()
end

function modifier_hwei_pool_of_reflection:OnRefresh( kv )
end

function modifier_hwei_pool_of_reflection:OnRemoved()
end

function modifier_hwei_pool_of_reflection:OnDestroy()
end

function modifier_hwei_pool_of_reflection:AddShieldValue( value )
	-- increment barrier value
	self.current_shield = self.current_shield + value
	if self.max_shield<self.current_shield then
		self.max_shield = self.current_shield
	end

	-- refresh shield on client using transmitter data
	self:SendBuffRefreshToClients()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_hwei_pool_of_reflection:AddCustomTransmitterData()
	-- on server
	local data = {
		current_shield = self.current_shield,
		max_shield = self.max_shield,
	}

	return data
end

function modifier_hwei_pool_of_reflection:HandleCustomTransmitterData( data )
	-- on client
	self.current_shield = data.current_shield
	self.max_shield = data.max_shield
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_pool_of_reflection:OnIntervalThink()
	-- regen if not in linger mode, which means still within area
	if self:GetRemainingTime()>self.linger then
		self:AddShieldValue( self.shield_per_second*self.interval )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_pool_of_reflection:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}

	return funcs
end

function modifier_hwei_pool_of_reflection:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end

	-- block based on damage
	local blocked = math.min( params.damage, self.current_shield )
	self.current_shield = self.current_shield - blocked

	-- refresh shield on client using transmitter data
	self:SendBuffRefreshToClients()

	-- play effects
	self:PlayEffectsHit()

	return -blocked
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_pool_of_reflection:PlayEffectsStart()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
end


function modifier_hwei_pool_of_reflection:PlayEffectsHit()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end