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
		self:PlayEffects()
		self:GetParent():AddNoDraw()
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
-- 	return "particles/units/heroes/hero_puck/puck_phase_shift.vpcf"
-- end

-- function modifier_puck_phase_shift_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

function modifier_puck_phase_shift_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_puck/puck_phase_shift.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
end

function modifier_puck_phase_shift_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end