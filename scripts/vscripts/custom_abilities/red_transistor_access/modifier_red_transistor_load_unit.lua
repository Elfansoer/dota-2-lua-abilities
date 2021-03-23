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
modifier_red_transistor_load_unit = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_load_unit:IsHidden()
	return false
end

function modifier_red_transistor_load_unit:IsDebuff()
	return false
end

function modifier_red_transistor_load_unit:IsStunDebuff()
	return false
end

function modifier_red_transistor_load_unit:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_load_unit:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	if not IsServer() then return end
	self.ability = self:GetAbility()
	self.radius = kv.radius
end

function modifier_red_transistor_load_unit:OnRefresh( kv )
	
end

function modifier_red_transistor_load_unit:OnRemoved()
end

function modifier_red_transistor_load_unit:OnDestroy()
	if not IsServer() then return end
	self:Explode()
	self:GetParent():ForceKill( false )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_load_unit:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_red_transistor_load_unit:OnTakeDamage( params )
	if params.unit~=self.parent then return end
	self:Destroy()
end

-- --------------------------------------------------------------------------------
-- -- Status Effects
-- function modifier_red_transistor_load_unit:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_STUNNED] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_load_unit:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_red_transistor_load_unit:Explode()
	-- unique area properties
	local area = {
		radius = self.radius,
		center_x = self.parent:GetOrigin().x,
		center_y = self.parent:GetOrigin().y,
		origin_x = self.caster:GetOrigin().x,
		origin_y = self.caster:GetOrigin().y,
	}

	-- call OnStart event
	self.ability:OnAreaStart( area )

	-- explode
	local enemies = self.ability:ProcessArea( area )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_red_transistor_load_unit:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_load_unit:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_load_unit:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_load_unit:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_load_unit:PlayEffects( radius )
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_techies/techies_land_mine_explode.vpcf"
-- 	-- local sound_cast = "string"

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
-- 	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
-- 	ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
-- 	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, radius, radius ) )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- -- Create Sound
-- 	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	-- EmitSoundOn( sound_target, target )
-- end