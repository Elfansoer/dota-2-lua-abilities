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
modifier_red_transistor_tap_lifesteal = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_tap_lifesteal:IsHidden()
	return true
end

function modifier_red_transistor_tap_lifesteal:IsDebuff()
	return false
end

function modifier_red_transistor_tap_lifesteal:IsStunDebuff()
	return false
end

function modifier_red_transistor_tap_lifesteal:IsPurgable()
	return false
end

function modifier_red_transistor_tap_lifesteal:RemoveOnDeath()
	return false
end

function modifier_red_transistor_tap_lifesteal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_tap_lifesteal:OnCreated( kv )
	if not IsServer() then return end
	self.lifesteal = kv.lifesteal
end

function modifier_red_transistor_tap_lifesteal:OnRefresh( kv )
	
end

function modifier_red_transistor_tap_lifesteal:OnRemoved()
end

function modifier_red_transistor_tap_lifesteal:OnDestroy()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_tap_lifesteal:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_red_transistor_tap_lifesteal:OnTakeDamage( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end
	if params.inflictor~=self:GetAbility() then return end

	-- heal
	local heal = params.damage * self.lifesteal/100
	self:GetParent():Heal( heal, self:GetAbility() )
	self:PlayEffects( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_red_transistor_tap_lifesteal:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_tap_lifesteal:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_tap_lifesteal:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_tap_lifesteal:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

function modifier_red_transistor_tap_lifesteal:PlayEffects( target )
	-- get resource
	local particle_cast = "particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf"

	-- play effects
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end