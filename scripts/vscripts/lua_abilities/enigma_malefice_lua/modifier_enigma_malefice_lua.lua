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
modifier_enigma_malefice_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enigma_malefice_lua:IsHidden()
	return false
end

function modifier_enigma_malefice_lua:IsDebuff()
	return true
end

function modifier_enigma_malefice_lua:IsStunDebuff()
	return false
end

function modifier_enigma_malefice_lua:IsPurgable()
	return true
end

-- function modifier_enigma_malefice_lua:GetAttributes()
-- 	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_INVULNERABLE 
-- end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enigma_malefice_lua:OnCreated( kv )
	-- references
	local tick_rate = self:GetAbility():GetSpecialValueFor( "tick_rate" )
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.stun = self:GetAbility():GetSpecialValueFor( "stun_duration" )

	if IsServer() then
		-- precache damage
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}
		-- ApplyDamage(damageTable)

		-- Start interval
		self:StartIntervalThink( tick_rate )
		self:OnIntervalThink()
	end
end

function modifier_enigma_malefice_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_enigma_malefice_lua:OnRemoved()
end

function modifier_enigma_malefice_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_enigma_malefice_lua:OnIntervalThink()
	-- stun
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.stun } -- kv
	)

	-- damage
	ApplyDamage( self.damageTable )

	-- effect
	local sound_cast = "Hero_Enigma.MaleficeTick"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_enigma_malefice_lua:GetEffectName()
	return "particles/units/heroes/hero_enigma/enigma_malefice.vpcf"
end

function modifier_enigma_malefice_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_enigma_malefice_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_enigma_malefice.vpcf"
end

-- function modifier_enigma_malefice_lua:PlayEffects()
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