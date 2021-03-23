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
modifier_red_transistor_cull_knockback = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_cull_knockback:IsHidden()
	return false
end

function modifier_red_transistor_cull_knockback:IsDebuff()
	return true
end

function modifier_red_transistor_cull_knockback:IsStunDebuff()
	return true
end

function modifier_red_transistor_cull_knockback:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_cull_knockback:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_red_transistor_cull_knockback:OnRefresh( kv )
	
end

function modifier_red_transistor_cull_knockback:OnRemoved()
end

function modifier_red_transistor_cull_knockback:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_cull_knockback:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_cull_knockback:OnAttack( params )

end

function modifier_red_transistor_cull_knockback:GetModifierMoveSpeedBonus_Percentage()
	return -100
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_red_transistor_cull_knockback:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_cull_knockback:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_red_transistor_cull_knockback:UpdateHorizontalMotion( me, dt )
end

function modifier_red_transistor_cull_knockback:OnHorizontalMotionInterrupted()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_red_transistor_cull_knockback:IsAura()
	return true
end

function modifier_red_transistor_cull_knockback:GetModifierAura()
	return "modifier_red_transistor_cull_knockback_effect"
end

function modifier_red_transistor_cull_knockback:GetAuraRadius()
	return self.radius
end

function modifier_red_transistor_cull_knockback:GetAuraDuration()
	return self.radius
end

function modifier_red_transistor_cull_knockback:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_red_transistor_cull_knockback:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_red_transistor_cull_knockback:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_red_transistor_cull_knockback:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_red_transistor_cull_knockback:GetEffectName()
	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
end

function modifier_red_transistor_cull_knockback:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_red_transistor_cull_knockback:GetStatusEffectName()
	return "status/effect/here.vpcf"
end

function modifier_red_transistor_cull_knockback:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_red_transistor_cull_knockback:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

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
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end