modifier_lifestealer_rage_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lifestealer_rage_lua:IsHidden()
	return false
end

function modifier_lifestealer_rage_lua:IsDebuff()
	return false
end

function modifier_lifestealer_rage_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lifestealer_rage_lua:OnCreated( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" ) -- special value
end

function modifier_lifestealer_rage_lua:OnRefresh( kv )
	-- references
	self.as_bonus = self:GetAbility():GetSpecialValueFor( "attack_speed_bonus" ) -- special value
end

function modifier_lifestealer_rage_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lifestealer_rage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_lifestealer_rage_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_bonus
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_lifestealer_rage_lua:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lifestealer_rage_lua:GetEffectName()
	return "particles/units/heroes/hero_life_stealer/life_stealer_rage.vpcf"
end

function modifier_lifestealer_rage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_lifestealer_rage_lua:PlayEffects()
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