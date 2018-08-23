modifier_earth_spirit_rolling_boulder_lua_slow = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_rolling_boulder_lua_slow:IsHidden()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsDebuff()
	return true
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsStunDebuff()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua_slow:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_rolling_boulder_lua_slow:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" ) -- special value
end

function modifier_earth_spirit_rolling_boulder_lua_slow:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "move_slow" ) -- special value	
end

function modifier_earth_spirit_rolling_boulder_lua_slow:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_earth_spirit_rolling_boulder_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_earth_spirit_rolling_boulder_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_earth_spirit_rolling_boulder_lua_slow:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_earth_spirit_rolling_boulder_lua_slow:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_earth_spirit_rolling_boulder_lua_slow:PlayEffects()
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