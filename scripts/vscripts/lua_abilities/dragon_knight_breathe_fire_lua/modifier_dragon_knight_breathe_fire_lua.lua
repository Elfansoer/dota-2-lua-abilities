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
modifier_dragon_knight_breathe_fire_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_breathe_fire_lua:IsHidden()
	return false
end

function modifier_dragon_knight_breathe_fire_lua:IsDebuff()
	return true
end

function modifier_dragon_knight_breathe_fire_lua:IsStunDebuff()
	return false
end

function modifier_dragon_knight_breathe_fire_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_breathe_fire_lua:OnCreated( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )
end

function modifier_dragon_knight_breathe_fire_lua:OnRefresh( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "reduction" )	
end

function modifier_dragon_knight_breathe_fire_lua:OnRemoved()
end

function modifier_dragon_knight_breathe_fire_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dragon_knight_breathe_fire_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_dragon_knight_breathe_fire_lua:GetModifierDamageOutgoing_Percentage()
	return self.reduction
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_dragon_knight_breathe_fire_lua:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_dragon_knight_breathe_fire_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_dragon_knight_breathe_fire_lua:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_dragon_knight_breathe_fire_lua:PlayEffects()
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