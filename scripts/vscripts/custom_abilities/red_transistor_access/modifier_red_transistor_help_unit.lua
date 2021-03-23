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
modifier_red_transistor_help_unit = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_help_unit:IsHidden()
	return false
end

function modifier_red_transistor_help_unit:IsDebuff()
	return false
end

function modifier_red_transistor_help_unit:IsStunDebuff()
	return false
end

function modifier_red_transistor_help_unit:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_help_unit:OnCreated( kv )
	if not IsServer() then return end

	self.radius = kv.radius
	self.ability = self:GetAbility()
end

function modifier_red_transistor_help_unit:OnRefresh( kv )
	
end

function modifier_red_transistor_help_unit:OnRemoved()
end

function modifier_red_transistor_help_unit:OnDestroy()
	if not IsServer() then return end
	self:GetParent():ForceKill( false )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_help_unit:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_LIFETIME_FRACTION,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_red_transistor_help_unit:GetUnitLifetimeFraction( params )
	return ( ( self:GetDieTime() - GameRules:GetGameTime() ) / self:GetDuration() )
end

function modifier_red_transistor_help_unit:GetModifierProcAttack_Feedback( params )
	local caster = self:GetCaster()
	local target = params.target

	-- unique area properties
	local area = {
		radius = self.radius,
		center_x = target:GetOrigin().x,
		center_y = target:GetOrigin().y,
		origin_x = caster:GetOrigin().x,
		origin_y = caster:GetOrigin().y,
	}

	-- call OnStart event
	self.ability:OnAreaStart( area )

	-- explode
	local enemies = self.ability:ProcessArea( area )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_red_transistor_help_unit:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_help_unit:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_help_unit:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_help_unit:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_help_unit:PlayEffects( data )
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_ember_spirit/ember_spirit_sleight_of_fist_cast.vpcf"

-- 	local center = GetGroundPosition(  )

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
-- 	ParticleManager:SetParticleControl( effect_cast, 0, data. )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end