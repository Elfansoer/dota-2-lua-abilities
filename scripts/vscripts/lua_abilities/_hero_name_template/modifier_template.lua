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

function modifier_template:GetAttributes()
	return MODIFIER_ATTRIBUTE_XX + MODIFIER_ATTRIBUTE_YY 
end

function modifier_template:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Aura
function modifier_template:IsAura()
	return true
end

function modifier_template:GetModifierAura()
	return "modifier_template_effect"
end

function modifier_template:GetAuraRadius()
	return float
end

function modifier_template:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_XX
end

function modifier_template:GetAuraSearchType()
	return DOTA_UNIT_TARGET_XX + DOTA_UNIT_TARGET_YY + ...
end

function modifier_template:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template:OnCreated( kv )
	-- references
	self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_template:OnRefresh( kv )
	
end

function modifier_template:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_template:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_XX,
		MODIFIER_EVENT_YY,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_template:CheckState()
	local state = {
	[MODIFIER_STATE_XX] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_template:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_template:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_template:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_template:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
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
		nFXIndex,
		bDestroyImmediately,
		bStatusEffect,
		iPriority,
		bHeroEffect,
		bOverheadEffect
	)

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end