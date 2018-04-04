modifier_bane_enfeeble_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bane_enfeeble_lua:IsHidden()
	return false
end

function modifier_bane_enfeeble_lua:IsDebuff()
	return true
end

function modifier_bane_enfeeble_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bane_enfeeble_lua:OnCreated( kv )
	-- references
	self.damage_reduction = -self:GetAbility():GetSpecialValueFor( "enfeeble_attack_reduction" ) -- special value
end

function modifier_bane_enfeeble_lua:OnRefresh( kv )
	-- references
	self.damage_reduction = -self:GetAbility():GetSpecialValueFor( "enfeeble_attack_reduction" ) -- special value
end

function modifier_bane_enfeeble_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_bane_enfeeble_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end
function modifier_bane_enfeeble_lua:GetModifierPreAttack_BonusDamage()
	return self.damage_reduction
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bane_enfeeble_lua:GetEffectName()
	return "particles/units/heroes/hero_bane/bane_enfeeble.vpcf"
end

function modifier_bane_enfeeble_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-- function modifier_bane_enfeeble_lua:PlayEffects()
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