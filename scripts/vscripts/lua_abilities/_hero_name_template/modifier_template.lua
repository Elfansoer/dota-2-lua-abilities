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
modifier_template = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_template:IsHidden()
	return false
end

function modifier_template:IsDebuff()
	return false
end

function modifier_template:IsStunDebuff()
	return false
end

function modifier_template:IsPurgable()
	return true
end

function modifier_template:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_INVULNERABLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" )

	if IsServer() then
		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
	end
end

function modifier_template:OnRefresh( kv )
	
end

function modifier_template:OnRemoved()
end

function modifier_template:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_template:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_template:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_template:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_template:UpdateHorizontalMotion( me, dt )
end

function modifier_template:OnHorizontalMotionInterrupted()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_template:IsAura()
	return true
end

function modifier_template:GetModifierAura()
	return "modifier_template_effect"
end

function modifier_template:GetAuraRadius()
	return self.radius
end

function modifier_template:GetAuraDuration()
	return self.radius
end

function modifier_template:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_template:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_template:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_template:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_template:GetEffectName()
	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
end

function modifier_template:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_template:GetStatusEffectName()
	return "status/effect/here.vpcf"
end

function modifier_template:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end