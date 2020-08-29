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
modifier_magnus_skewer_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_magnus_skewer_lua_slow:IsHidden()
	return false
end

function modifier_magnus_skewer_lua_slow:IsDebuff()
	return true
end

function modifier_magnus_skewer_lua_slow:IsStunDebuff()
	return false
end

function modifier_magnus_skewer_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_magnus_skewer_lua_slow:OnCreated( kv )
	-- references
	self.as_slow = -self:GetAbility():GetSpecialValueFor( "tool_attack_slow" )
	self.ms_slow = -self:GetAbility():GetSpecialValueFor( "slow_pct" )

	if not IsServer() then return end
end

function modifier_magnus_skewer_lua_slow:OnRefresh( kv )
	
end

function modifier_magnus_skewer_lua_slow:OnRemoved()
end

function modifier_magnus_skewer_lua_slow:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_magnus_skewer_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_magnus_skewer_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_magnus_skewer_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_magnus_skewer_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_magnataur/magnataur_skewer_debuff.vpcf"
end

function modifier_magnus_skewer_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_magnus_skewer_lua_slow:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_magnus_skewer_lua_slow:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_magnus_skewer_lua_slow:PlayEffects()
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