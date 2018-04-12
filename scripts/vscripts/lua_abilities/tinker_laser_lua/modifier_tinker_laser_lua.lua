modifier_tinker_laser_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_laser_lua:IsHidden()
	return false
end

function modifier_tinker_laser_lua:IsDebuff()
	return true
end

function modifier_tinker_laser_lua:IsStunDebuff()
	return false
end

function modifier_tinker_laser_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_laser_lua:OnCreated( kv )
	-- references
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_lua:OnRefresh( kv )
	-- references
	self.miss_rate = self:GetAbility():GetSpecialValueFor( "miss_rate" )
end

function modifier_tinker_laser_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tinker_laser_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
	}

	return funcs
end

function modifier_tinker_laser_lua:GetModifierMiss_Percentage()
	return self.miss_rate
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_tinker_laser_lua:GetEffectName()
	return "particles/string/here.vpcf"
end

function modifier_tinker_laser_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_tinker_laser_lua:PlayEffects()
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