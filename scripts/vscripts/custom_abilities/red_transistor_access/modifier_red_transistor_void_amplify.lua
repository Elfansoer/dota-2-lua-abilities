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
modifier_red_transistor_void_amplify = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_void_amplify:IsHidden()
	return false
end

function modifier_red_transistor_void_amplify:IsDebuff()
	return true
end

function modifier_red_transistor_void_amplify:IsStunDebuff()
	return false
end

function modifier_red_transistor_void_amplify:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_void_amplify:OnCreated( kv )
	if not IsServer() then return end
	self.max_amplify = kv.max_amplify
	self.amplify = kv.amplify
	self:SetStackCount( self.amplify )
end

function modifier_red_transistor_void_amplify:OnRefresh( kv )
	if not IsServer() then return end
	self.max_amplify = kv.max_amplify
	self.amplify = math.min( self.amplify + kv.amplify, self.max_amplify )
	self:SetStackCount( self.amplify )
end

function modifier_red_transistor_void_amplify:OnRemoved()
end

function modifier_red_transistor_void_amplify:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_void_amplify:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_void_amplify:GetModifierIncomingDamage_Percentage()
	return self:GetStackCount()
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_void_amplify:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_void_amplify:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_void_amplify:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_void_amplify:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_void_amplify:PlayEffects()
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