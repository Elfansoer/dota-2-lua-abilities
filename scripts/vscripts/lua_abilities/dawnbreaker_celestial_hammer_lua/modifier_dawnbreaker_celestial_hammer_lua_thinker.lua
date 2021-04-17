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
modifier_dawnbreaker_celestial_hammer_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_celestial_hammer_lua_thinker:IsHidden()
	return true
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_celestial_hammer_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.name = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_return.vpcf"
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
	self.delay = self:GetAbility():GetSpecialValueFor( "pause_duration" )
	self.duration = self:GetAbility():GetSpecialValueFor( "flare_debuff_duration" )
	self.vision = 200
	self.interval = 0.1

	-- NOTE: arbitrary decision to mimic original spell
	self.max_return = 1.5

	if not IsServer() then return end

	-- play effects
	local sound_loop = "Hero_Dawnbreaker.Celestial_Hammer.Projectile"
	EmitSoundOn( sound_loop, self.parent )
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:OnRefresh( kv )
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:OnRemoved()
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_celestial_hammer_lua_thinker:OnIntervalThink()
	if not self.converge then
		self:Return()
		return
	end

	-- create trail
	local thinker = CreateModifierThinker(
		self.caster, -- player source
		self.ability, -- ability source
		"modifier_dawnbreaker_celestial_hammer_lua_trail", -- modifier name
		{
			duration = self.duration,
			x = self.prev_pos.x,
			y = self.prev_pos.y,
		}, -- kv
		self.parent:GetOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
	self.prev_pos = self.parent:GetOrigin()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_dawnbreaker_celestial_hammer_lua_thinker:Delay()
	self:PlayEffects1()
	self:StartIntervalThink( self.delay )

	-- add viewer
	AddFOWViewer( self.caster:GetTeamNumber(), self.parent:GetOrigin(), self.vision, self.delay, false)
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:Return()
	if self.converge then return end

	self.converge = true
	self.prev_pos = self.parent:GetOrigin()
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()

	-- calculate speed
	self.distance = (self.parent:GetOrigin()-self.caster:GetOrigin()):Length2D()
	if self.distance > self.speed*self.max_return then
		self.speed = self.distance/self.max_return
	end

	-- create projectile
	local info = {
		Target = self.caster,
		Source = self.parent,
		Ability = self.ability,	
		
		EffectName = self.name,
		iMoveSpeed = self.speed,
		bDodgeable = false,
	}
	local data = {
		cast = 2,
		targets = {},
		thinker = self.parent,
	}
	local id = ProjectileManager:CreateTrackingProjectile(info)
	self.ability.projectiles[id] = data

	-- play effects
	self:PlayEffects2()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_celestial_hammer_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_celestial_hammer_grounded.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Celestial_Hammer.Impact"

	-- Get Data
	local direction = self:GetParent():GetOrigin()-self:GetCaster():GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 0, direction )
	self.effect_cast = effect_cast

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
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dawnbreaker_celestial_hammer_lua_thinker:PlayEffects2()
	if self.effect_cast then
		ParticleManager:DestroyParticle( self.effect_cast, false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast )
	end

	local sound_cast = "Hero_Dawnbreaker.Celestial_Hammer.Return"
	EmitSoundOn( sound_cast, self.parent )
end