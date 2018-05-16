modifier_sona_crescendo_perseverance = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sona_crescendo_perseverance:IsHidden()
	return false
end

function modifier_sona_crescendo_perseverance:IsDebuff()
	return false
end

function modifier_sona_crescendo_perseverance:IsPurgable()
	return false
end

function modifier_sona_crescendo_perseverance:GetTexture()
	return "custom/sona_aria_of_perseverance"
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_sona_crescendo_perseverance:OnCreated( kv )
	-- references
	self.armor_bonus = self:GetAbility():GetSpecialValueFor( "perseverance_armor" ) -- special value
	self.magic_bonus = self:GetAbility():GetSpecialValueFor( "perseverance_magic" ) -- special value
end

function modifier_sona_crescendo_perseverance:OnRefresh( kv )
	-- references
	self.armor_bonus = self:GetAbility():GetSpecialValueFor( "perseverance_armor" ) -- special value
	self.magic_bonus = self:GetAbility():GetSpecialValueFor( "perseverance_magic" ) -- special value	
end

function modifier_sona_crescendo_perseverance:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sona_crescendo_perseverance:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}

	return funcs
end

function modifier_sona_crescendo_perseverance:GetModifierPhysicalArmorBonus()
	return self.armor_bonus
end
function modifier_sona_crescendo_perseverance:GetModifierMagicalResistanceBonus()
	return self.magic_bonus
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_sona_crescendo_perseverance:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sona_crescendo_perseverance:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_sona_crescendo_perseverance:PlayEffects()
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