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
modifier_red_transistor_purge_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_purge_debuff:IsHidden()
	return false
end

function modifier_red_transistor_purge_debuff:IsDebuff()
	return true
end

function modifier_red_transistor_purge_debuff:IsStunDebuff()
	return false
end

function modifier_red_transistor_purge_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_purge_debuff:OnCreated( kv )
	if not IsServer() then return end

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = kv.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	-- self:StartIntervalThink( kv.interval )
	self:StartIntervalThink( 1 )
end

function modifier_red_transistor_purge_debuff:OnRefresh( kv )
	if not IsServer() then return end
	self.damageTable.damage = kv.damage
end

function modifier_red_transistor_purge_debuff:OnRemoved()
end

function modifier_red_transistor_purge_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_purge_debuff:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_purge_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -100
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_purge_debuff:OnIntervalThink()
	ApplyDamage( self.damageTable )

	-- overhead damage info
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
		self:GetParent(),
		self.damageTable.damage,
		self:GetCaster():GetPlayerOwner()
	)
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_purge_debuff:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_purge_debuff:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_purge_debuff:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_purge_debuff:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_purge_debuff:PlayEffects()
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