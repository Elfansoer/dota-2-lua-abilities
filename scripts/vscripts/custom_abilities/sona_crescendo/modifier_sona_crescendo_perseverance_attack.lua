modifier_sona_crescendo_perseverance_attack = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_perseverance_attack:IsHidden()
	return false
end

function modifier_sona_crescendo_perseverance_attack:IsDebuff()
	return true
end

function modifier_sona_crescendo_perseverance_attack:IsPurgable()
	return true
end

function modifier_sona_crescendo_perseverance_attack:GetTexture()
	return "custom/sona_aria_of_perseverance"
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_perseverance_attack:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_sona_crescendo_perseverance_attack:OnTakeDamage( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end

		if params.unit:GetHealth()<=0 then
			params.unit:SetHealth(1)
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_perseverance_attack:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_perseverance_attack:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_perseverance_attack:PlayEffects()
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