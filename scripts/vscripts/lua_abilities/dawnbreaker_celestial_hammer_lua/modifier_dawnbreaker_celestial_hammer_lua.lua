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
modifier_dawnbreaker_celestial_hammer_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_celestial_hammer_lua:IsHidden()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua:IsDebuff()
	return false
end

function modifier_dawnbreaker_celestial_hammer_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_celestial_hammer_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
	self.speed_pct = self:GetAbility():GetSpecialValueFor( "travel_speed_pct" )
	self.duration = self:GetAbility():GetSpecialValueFor( "flare_debuff_duration" )
	self.interval = 0.1


	if not IsServer() then return end

	-- NOTE: arbitrary decision to mimic original spell
	self.max_range = self:GetAbility():GetSpecialValueFor( "range" )
	self.origin = self.parent:GetOrigin()

	self.prev_pos = self.parent:GetOrigin()
	self.actual_speed = self.speed*self.speed_pct/100
	self.target = EntIndexToHScript( kv.target )

	-- set forward
	local direction = self.target:GetOrigin()-self.parent:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	self.parent:SetForwardVector( direction )

	-- move
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()

	-- play effects
	self:PlayEffects()
end

function modifier_dawnbreaker_celestial_hammer_lua:OnRefresh( kv )
end

function modifier_dawnbreaker_celestial_hammer_lua:OnRemoved()
end

function modifier_dawnbreaker_celestial_hammer_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_celestial_hammer_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}

	return funcs
end

function modifier_dawnbreaker_celestial_hammer_lua:GetModifierDisableTurning()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dawnbreaker_celestial_hammer_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dawnbreaker_celestial_hammer_lua:OnIntervalThink()
	-- create trail
	local thinker = CreateModifierThinker(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_dawnbreaker_celestial_hammer_lua_trail", -- modifier name
		{
			duration = self.duration,
			x = self.prev_pos.x,
			y = self.prev_pos.y,
		}, -- kv
		self.parent:GetOrigin(),
		self.parent:GetTeamNumber(),
		false
	)
	self.prev_pos = self.parent:GetOrigin()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_dawnbreaker_celestial_hammer_lua:UpdateHorizontalMotion( me, dt )
	local dist = (self.origin-me:GetOrigin()):Length2D()
	if dist>self.max_range then
		self:Destroy()
		return
	end

	local pos = me:GetOrigin() + me:GetForwardVector() * self.actual_speed * dt

	pos = GetGroundPosition( pos, me )
	me:SetOrigin( pos )
end

function modifier_dawnbreaker_celestial_hammer_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_celestial_hammer_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_trail.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 0, self.parent:GetForwardVector() )

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