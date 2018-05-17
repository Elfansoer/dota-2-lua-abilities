modifier_shaco_jack_in_the_box_fear = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_shaco_jack_in_the_box_fear:IsHidden()
	return false
end

function modifier_shaco_jack_in_the_box_fear:IsDebuff()
	return true
end

function modifier_shaco_jack_in_the_box_fear:IsStunDebuff()
	return false
end

function modifier_shaco_jack_in_the_box_fear:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shaco_jack_in_the_box_fear:OnCreated( kv )
	-- generate data
	self.interval = 0.2
	self.distance = 150

	if IsServer() then
		-- references
		self.fear_pos = Vector( kv.center_x, kv.center_y, 0 )

		-- run direction
		self.direction = self.fear_pos-self:GetParent():GetOrigin()
		self.direction.z = 0
		self.direction = -self.direction:Normalized()

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
	end
end

function modifier_shaco_jack_in_the_box_fear:OnRefresh( kv )
	if IsServer() then
		-- references
		self.fear_pos = Vector( kv.center_x, kv.center_y, 0 )

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
	end
end

function modifier_shaco_jack_in_the_box_fear:OnDestroy( kv )
	if IsServer() then
		self:GetParent():Stop()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_shaco_jack_in_the_box_fear:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_PROPERTY_XX,
-- 		MODIFIER_EVENT_YY,
-- 	}

-- 	return funcs
-- end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_shaco_jack_in_the_box_fear:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_shaco_jack_in_the_box_fear:OnIntervalThink()
	-- run direction
	self.direction = self.fear_pos-self:GetParent():GetOrigin()
	self.direction.z = 0
	self.direction = -self.direction:Normalized()

	-- forced run
	self:GetParent():MoveToPosition( self:GetParent():GetOrigin() + self.direction * self.distance )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_shaco_jack_in_the_box_fear:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_shaco_jack_in_the_box_fear:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_shaco_jack_in_the_box_fear:PlayEffects()
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