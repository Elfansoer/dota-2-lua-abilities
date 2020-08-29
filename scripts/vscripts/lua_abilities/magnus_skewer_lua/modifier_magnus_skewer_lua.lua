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
modifier_magnus_skewer_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magnus_skewer_lua:IsHidden()
	return false
end

function modifier_magnus_skewer_lua:IsDebuff()
	return false
end

function modifier_magnus_skewer_lua:IsStunDebuff()
	return false
end

function modifier_magnus_skewer_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magnus_skewer_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "skewer_radius" )
	self.speed = self:GetAbility():GetSpecialValueFor( "skewer_speed" )
	self.tree = self:GetAbility():GetSpecialValueFor( "tree_radius" )

	if not IsServer() then return end

	-- get data
	self.origin = self:GetParent():GetOrigin()
	self.point = Vector( kv.x, kv.y, 0 )
	self.direction = self.point - self.origin
	self.distance = self.direction:Length2D()

	self.direction.z = 0
	self.direction = self.direction:Normalized()

	-- init
	self.enemies = {}

	-- motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- play effects
	self:PlayEffects()
end

function modifier_magnus_skewer_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_magnus_skewer_lua:OnRemoved()
end

function modifier_magnus_skewer_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magnus_skewer_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_magnus_skewer_lua:GetOverrideAnimation()
	return ACT_DOTA_MAGNUS_SKEWER_START
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_magnus_skewer_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_magnus_skewer_lua:UpdateHorizontalMotion( me, dt )
	local origin = me:GetOrigin()
	local target = origin + self.direction*self.speed*dt
	me:SetOrigin( target )

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( origin, self.tree, false )

	-- check distance
	local dist = (target-self.origin):Length2D()
	if dist>self.distance then
		self:Destroy()
	end
end

function modifier_magnus_skewer_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_magnus_skewer_lua:IsAura()
	return true
end

function modifier_magnus_skewer_lua:GetModifierAura()
	return "modifier_magnus_skewer_lua_debuff"
end

function modifier_magnus_skewer_lua:GetAuraRadius()
	return self.radius
end

function modifier_magnus_skewer_lua:GetAuraDuration()
	return 0.1
end

function modifier_magnus_skewer_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_magnus_skewer_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_magnus_skewer_lua:GetAuraSearchFlags()
	return 0
end

function modifier_magnus_skewer_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_magnus_skewer_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_magnataur/magnataur_skewer.vpcf"
	local sound_cast = "Hero_Magnataur.Skewer.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_horn",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, 1, self:GetParent():GetForwardVector() )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

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
	EmitSoundOn( sound_cast, self:GetParent() )
end