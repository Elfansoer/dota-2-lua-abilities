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
modifier_dark_willow_bedlam_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_bedlam_lua:IsHidden()
	return false
end

function modifier_dark_willow_bedlam_lua:IsDebuff()
	return false
end

function modifier_dark_willow_bedlam_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_bedlam_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.zero = Vector(0,0,0)

	-- references
	self.revolution = self:GetAbility():GetSpecialValueFor( "roaming_seconds_per_rotation" )
	self.rotate_radius = self:GetAbility():GetSpecialValueFor( "roaming_radius" )

	if not IsServer() then return end

	-- init data
	self.interval = 0.03
	self.base_facing = Vector(0,1,0)
	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval

	-- set init location
	self.position = self.parent:GetOrigin() + self.relative_pos
	self.rotation = 0
	self.facing = self.base_facing

	-- create wisp
	self.wisp = CreateUnitByName(
		"npc_dota_dark_willow_creature",
		self.position,
		true,
		self.parent,
		self.parent:GetOwner(),
		self.parent:GetTeamNumber()
	)
	self.wisp:SetForwardVector( self.facing )
	self.wisp:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_wisp_ambient", -- modifier name
		{} -- kv
	)

	-- add attack modifier
	self.wisp:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_dark_willow_bedlam_lua_attack", -- modifier name
		{ duration = kv.duration } -- kv
	)

	-- Start interval
	self:StartIntervalThink( self.interval )

	-- deactivate ability
	local ability = self:GetCaster():FindAbilityByName( "dark_willow_terrorize_lua" )
	if ability then ability:SetActivated( false ) end

	-- play effects
	self:PlayEffects()
end

function modifier_dark_willow_bedlam_lua:OnRefresh( kv )
	-- refresh references
	self.revolution = self:GetAbility():GetSpecialValueFor( "roaming_seconds_per_rotation" )
	self.rotate_radius = self:GetAbility():GetSpecialValueFor( "roaming_radius" )

	if not IsServer() then return end

	self.relative_pos = Vector( -self.rotate_radius, 0, 100 )
	self.rotate_delta = 360/self.revolution * self.interval

	-- refresh attack modifier
	self.wisp:AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_dark_willow_bedlam_lua_attack", -- modifier name
		{ duration = kv.duration } -- kv
	)
end

function modifier_dark_willow_bedlam_lua:OnRemoved()
end

function modifier_dark_willow_bedlam_lua:OnDestroy()
	if not IsServer() then return end

	-- kill the wisp
	UTIL_Remove( self.wisp )
	-- self.wisp:ForceKill( false )

	-- reactivate ability
	local ability = self:GetCaster():FindAbilityByName( "dark_willow_terrorize_lua" )
	if ability then ability:SetActivated( true ) end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_willow_bedlam_lua:OnIntervalThink()
	-- update position
	self.rotation = self.rotation + self.rotate_delta
	local origin = self.parent:GetOrigin()
	self.position = RotatePosition( origin, QAngle( 0, -self.rotation, 0 ), origin + self.relative_pos )
	self.facing = RotatePosition( self.zero, QAngle( 0, -self.rotation, 0 ), self.base_facing )

	-- update wisp
	self.wisp:SetOrigin( self.position )
	self.wisp:SetForwardVector( self.facing )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_willow_bedlam_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_wisp_aoe_cast.vpcf"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( self.rotate_radius, self.rotate_radius, self.rotate_radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end