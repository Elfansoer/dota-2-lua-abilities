modifier_sona_crescendo_valor_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_valor_attack:IsHidden()
	return false
end

function modifier_sona_crescendo_valor_attack:IsDebuff()
	return true
end

function modifier_sona_crescendo_valor_attack:IsPurgable()
	return true
end

function modifier_sona_crescendo_valor_attack:GetTexture()
	return "custom/sona_hymn_of_valor"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_crescendo_valor_attack:OnCreated( kv )
	-- references
	self.input = self:GetAbility():GetSpecialValueFor( "valor_attack" ) -- special value
end

function modifier_sona_crescendo_valor_attack:OnRefresh( kv )
	-- references
	self.input = self:GetAbility():GetSpecialValueFor( "valor_attack" ) -- special value
end

function modifier_sona_crescendo_valor_attack:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_valor_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_sona_crescendo_valor_attack:GetModifierIncomingDamage_Percentage()
	return self.input
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_valor_attack:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_valor_attack:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_valor_attack:PlayEffects()
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