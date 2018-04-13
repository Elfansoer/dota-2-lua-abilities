modifier_puck_phase_shift_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_puck_phase_shift_lua:IsHidden()
	return false
end

function modifier_puck_phase_shift_lua:IsDebuff()
	return false
end

function modifier_puck_phase_shift_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_puck_phase_shift_lua:OnCreated( kv )
	if IsServer() then
		self:GetParent():AddNoDraw()
		self:PlayEffects()
	end
end

function modifier_puck_phase_shift_lua:OnRefresh( kv )
	
end

function modifier_puck_phase_shift_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():RemoveNoDraw()
		self:StopEffects()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_puck_phase_shift_lua:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_EVENT_ON_ORDER,
-- 	}

-- 	return funcs
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_puck_phase_shift_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_puck_phase_shift_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_puck_phase_shift_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_puck_phase_shift_lua:PlayEffects()
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