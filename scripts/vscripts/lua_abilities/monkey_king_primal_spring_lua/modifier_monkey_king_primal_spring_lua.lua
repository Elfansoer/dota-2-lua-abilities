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
modifier_monkey_king_primal_spring_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_monkey_king_primal_spring_lua:IsHidden()
	return false
end

function modifier_monkey_king_primal_spring_lua:IsDebuff()
	return true
end

function modifier_monkey_king_primal_spring_lua:IsStunDebuff()
	return false
end

function modifier_monkey_king_primal_spring_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_monkey_king_primal_spring_lua:OnCreated( kv )
	if not IsServer() then
		self.slow = self:GetStackCount()
		self:SetStackCount( 0 )
		return
	end
	-- references
	self.slow = kv.slow
	self:SetStackCount( self.slow )
end

function modifier_monkey_king_primal_spring_lua:OnRefresh( kv )
	-- references
	self.slow = math.max( self.slow, kv.slow )
	self:SetStackCount( self.slow )	
end

function modifier_monkey_king_primal_spring_lua:OnRemoved()
end

function modifier_monkey_king_primal_spring_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_monkey_king_primal_spring_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_monkey_king_primal_spring_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_monkey_king_primal_spring_lua:GetEffectName()
	return "particles/units/heroes/hero_monkey_king/monkey_king_spring_slow.vpcf"
end

function modifier_monkey_king_primal_spring_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_monkey_king_primal_spring_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_monkey_king_spring_slow.vpcf"
end

function modifier_monkey_king_primal_spring_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

-- function modifier_monkey_king_primal_spring_lua:PlayEffects()
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