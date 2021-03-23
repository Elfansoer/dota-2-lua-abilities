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
modifier_red_transistor_mask_invisible = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_mask_invisible:IsHidden()
	return false
end

function modifier_red_transistor_mask_invisible:IsDebuff()
	return false
end

function modifier_red_transistor_mask_invisible:IsStunDebuff()
	return false
end

function modifier_red_transistor_mask_invisible:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_mask_invisible:OnCreated( kv )
	if not IsServer() then return end
	self.backstab = kv.backstab
end

function modifier_red_transistor_mask_invisible:OnRefresh( kv )
	if not IsServer() then return end
	self.backstab = kv.backstab	
end

function modifier_red_transistor_mask_invisible:OnRemoved()
end

function modifier_red_transistor_mask_invisible:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_mask_invisible:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,

		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_red_transistor_mask_invisible:GetModifierInvisibilityLevel()
	return 1
end

function modifier_red_transistor_mask_invisible:OnAbilityExecuted( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end

	self:SetDuration( 0.5, false )
end

function modifier_red_transistor_mask_invisible:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end

	self:Destroy()
	return self.backstab
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_red_transistor_mask_invisible:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
	}

	return state
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_mask_invisible:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_mask_invisible:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_mask_invisible:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_mask_invisible:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_mask_invisible:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_POINT_FOLLOW,
-- 		"attach_hitloc",
-- 		Vector(0,0,0), -- unknown
-- 		true -- unknown, true
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