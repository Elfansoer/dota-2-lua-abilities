modifier_sona_song_of_celerity = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_song_of_celerity:IsHidden()
	return false
end

function modifier_sona_song_of_celerity:IsDebuff()
	return false
end

function modifier_sona_song_of_celerity:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_sona_song_of_celerity:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_song_of_celerity:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "as_bonus" ) -- special value
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "ms_bonus" ) -- special value
end

function modifier_sona_song_of_celerity:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_song_of_celerity:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_sona_song_of_celerity:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end
function modifier_sona_song_of_celerity:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_song_of_celerity:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_song_of_celerity:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_song_of_celerity:PlayEffects()
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