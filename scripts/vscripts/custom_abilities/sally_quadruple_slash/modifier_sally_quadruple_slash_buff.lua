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
modifier_sally_quadruple_slash_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_quadruple_slash_buff:IsHidden()
	return true
end

function modifier_sally_quadruple_slash_buff:IsDebuff()
	return false
end

function modifier_sally_quadruple_slash_buff:IsPurgable()
	return false
end

function modifier_sally_quadruple_slash_buff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_quadruple_slash_buff:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.max_attacks = self:GetAbility():GetSpecialValueFor( "attack_count" ) - 1
	self.interval = self:GetAbility():GetSpecialValueFor( "attack_interval" )

	if not IsServer() then return end
	self.target = nil
	self.attacking = false
	self.attacks = 0
	self.intrinsic = self.parent:FindModifierByName("modifier_sally_quadruple_slash")
end

function modifier_sally_quadruple_slash_buff:OnRefresh( kv )
end

function modifier_sally_quadruple_slash_buff:OnRemoved()
end

function modifier_sally_quadruple_slash_buff:OnDestroy()
end

-- OnCreated can only accept integer and string
function modifier_sally_quadruple_slash_buff:Init( target )
	self.target = target
	self:StartIntervalThink( self.interval )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_quadruple_slash_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

function modifier_sally_quadruple_slash_buff:OnAttack( params )
	if self.attacking then
		self.intrinsic:RegisterAttack( params.record )
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sally_quadruple_slash_buff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sally_quadruple_slash_buff:OnIntervalThink()
	-- can't get attack record from PerformAttack, so use this instead
	self.attacking = true
	self.parent:PerformAttack( self.target, false, true, true, true, true, false, false)
	self.attacking = false

	self:PlayEffects( self.parent, self.target )

	self.attacks = self.attacks + 1
	if self.attacks >= self.max_attacks then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sally_quadruple_slash_buff:PlayEffects( caster, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end