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
modifier_red_transistor_flood_damage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_flood_damage:IsHidden()
	return true
end

function modifier_red_transistor_flood_damage:IsDebuff()
	return false
end

function modifier_red_transistor_flood_damage:IsStunDebuff()
	return false
end

function modifier_red_transistor_flood_damage:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_flood_damage:OnCreated( kv )
	if not IsServer() then return end
	self.dps = kv.dps
	self.interval = kv.interval

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.dps*self.interval,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_red_transistor_flood_damage:OnRefresh( kv )
	if not IsServer() then return end
	self.dps = kv.dps

	-- update damage
	self.damageTable.damage = self.dps * self.interval
end

function modifier_red_transistor_flood_damage:OnRemoved()
end

function modifier_red_transistor_flood_damage:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_flood_damage:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_flood_damage:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_flood_damage:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_flood_damage:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_flood_damage:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_flood_damage:PlayEffects()
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