modifier_sona_crescendo_celerity_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_celerity_attack:IsHidden()
	return false
end

function modifier_sona_crescendo_celerity_attack:IsDebuff()
	return true
end

function modifier_sona_crescendo_celerity_attack:IsPurgable()
	return true
end

function modifier_sona_crescendo_celerity_attack:GetTexture()
	return "custom/sona_song_of_celerity"
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_crescendo_celerity_attack:OnCreated( kv )
	-- references
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "celerity_slow" ) -- special value
end

function modifier_sona_crescendo_celerity_attack:OnRefresh( kv )
	-- references
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "celerity_slow" ) -- special value
end

function modifier_sona_crescendo_celerity_attack:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_celerity_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_sona_crescendo_celerity_attack:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_celerity_attack:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_celerity_attack:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_celerity_attack:PlayEffects()
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