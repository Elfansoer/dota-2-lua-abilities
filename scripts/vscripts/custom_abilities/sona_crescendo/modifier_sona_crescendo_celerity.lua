modifier_sona_crescendo_celerity = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_celerity:IsHidden()
	return false
end

function modifier_sona_crescendo_celerity:IsDebuff()
	return false
end

function modifier_sona_crescendo_celerity:IsPurgable()
	return false
end

function modifier_sona_crescendo_celerity:GetTexture()
	return "custom/sona_song_of_celerity"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_crescendo_celerity:OnCreated( kv )
	self.caster = self:GetCaster()
end

function modifier_sona_crescendo_celerity:OnRefresh( kv )
	
end

function modifier_sona_crescendo_celerity:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_celerity:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}

	return funcs
end

function modifier_sona_crescendo_celerity:GetModifierMoveSpeed_AbsoluteMin()
	if IsServer() then
		if self:GetParent()~=self.caster then
			return self.caster:GetMoveSpeedModifier( self.caster:GetBaseMoveSpeed() )
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_celerity:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_celerity:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_celerity:PlayEffects()
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