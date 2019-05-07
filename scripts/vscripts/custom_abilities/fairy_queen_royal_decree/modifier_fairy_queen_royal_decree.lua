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
modifier_fairy_queen_royal_decree = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_royal_decree:IsHidden()
	return false
end

function modifier_fairy_queen_royal_decree:IsDebuff()
	return false
end

function modifier_fairy_queen_royal_decree:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_royal_decree:OnCreated( kv )
	-- references
	self.cooldown_reduction = self:GetAbility():GetSpecialValueFor( "cooldown_reduction" )
end

function modifier_fairy_queen_royal_decree:OnRefresh( kv )
	-- references
	self.cooldown_reduction = self:GetAbility():GetSpecialValueFor( "cooldown_reduction" )
end

function modifier_fairy_queen_royal_decree:OnRemoved()
end

function modifier_fairy_queen_royal_decree:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_fairy_queen_royal_decree:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_CHANGE_ABILITY_VALUE,
	}

	return funcs
end

function modifier_fairy_queen_royal_decree:GetModifierChangeAbilityValue( params )
	print("abilityvalue",params)
	return 1
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_fairy_queen_royal_decree:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_fairy_queen_royal_decree:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_fairy_queen_royal_decree:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_fairy_queen_royal_decree:PlayEffects()
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