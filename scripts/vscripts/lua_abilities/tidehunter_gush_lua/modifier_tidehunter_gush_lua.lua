modifier_tidehunter_gush_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tidehunter_gush_lua:IsHidden()
	return false
end

function modifier_tidehunter_gush_lua:IsDebuff()
	return true
end

function modifier_tidehunter_gush_lua:IsStunDebuff()
	return false
end

function modifier_tidehunter_gush_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tidehunter_gush_lua:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_speed" ) -- special value
	self.armor = -self:GetAbility():GetSpecialValueFor( "negative_armor" ) -- special value
end

function modifier_tidehunter_gush_lua:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_speed" ) -- special value
	self.armor = -self:GetAbility():GetSpecialValueFor( "negative_armor" ) -- special value	
end

function modifier_tidehunter_gush_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_tidehunter_gush_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_tidehunter_gush_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end
function modifier_tidehunter_gush_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_tidehunter_gush_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_tidehunter_gush_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_tidehunter_gush_lua:PlayEffects()
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