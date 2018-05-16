modifier_sona_crescendo_valor = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_valor:IsHidden()
	return false
end

function modifier_sona_crescendo_valor:IsDebuff()
	return false
end

function modifier_sona_crescendo_valor:IsPurgable()
	return false
end

function modifier_sona_crescendo_valor:GetTexture()
	return "custom/sona_hymn_of_valor"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_crescendo_valor:OnCreated( kv )
	-- references
	self.output = self:GetAbility():GetSpecialValueFor( "valor_aura" ) -- special value
end

function modifier_sona_crescendo_valor:OnRefresh( kv )
	-- references
	self.output = self:GetAbility():GetSpecialValueFor( "valor_aura" ) -- special value
end

function modifier_sona_crescendo_valor:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_valor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end

function modifier_sona_crescendo_valor:GetModifierDamageOutgoing_Percentage()
	return self.output
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_valor:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_valor:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_valor:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
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
-- 		nFXIndex,
-- 		bDestroyImmediately,
-- 		bStatusEffect,
-- 		iPriority,
-- 		bHeroEffect,
-- 		bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end