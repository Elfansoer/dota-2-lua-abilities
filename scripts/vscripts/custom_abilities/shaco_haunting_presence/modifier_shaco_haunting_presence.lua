modifier_shaco_haunting_presence = class({})
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Classifications
function modifier_shaco_haunting_presence:IsHidden()
	return false
end

function modifier_shaco_haunting_presence:IsDebuff()
	return false
end

function modifier_shaco_haunting_presence:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_shaco_haunting_presence:OnCreated( kv )
	if IsServer() then
		-- references
		self.target = tempTable:RetATValue(kv.target)
		self.distance = self:GetAbility():GetSpecialValueFor( "distance" ) -- special value

		-- find angle from forward
		local facing_angle = self.target:GetAnglesAsVector().y
		local starting_angle = VectorToAngles(self:GetParent():GetOrigin()-self.target:GetOrigin()).y
		self.angle_diff = AngleDiff( facing_angle, starting_angle )

		-- start motion
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end
	end
end

function modifier_shaco_haunting_presence:OnRefresh( kv )
	
end

function modifier_shaco_haunting_presence:OnDestroy( kv )
	if IsServer() then
		self:GetParent():StopFacing()
		
		-- IMPORTANT: this is a must, or else the game will crash!
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_shaco_haunting_presence:UpdateHorizontalMotion( me, dt )
	if IsServer() then
		-- cancel cases
		if self:GetParent():IsStunned() then
			self:Destroy()
		end

		-- get relative position
		local forward_angle = VectorToAngles(self.target:GetForwardVector()).y
		local target_angle = forward_angle - self.angle_diff
		target_angle = math.rad(target_angle)
		local target_vec = Vector( math.cos(target_angle), math.sin(target_angle), 0 ):Normalized() * self.distance

		-- actual position
		target_vec = self.target:GetOrigin() + target_vec

		-- move to position
		self:GetParent():SetOrigin( target_vec )
		self:GetParent():FaceTowards(self.target:GetOrigin())
	end
end

function modifier_shaco_haunting_presence:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_shaco_haunting_presence:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_EVENT_ON_STATE_CHANGED,
-- 	}

-- 	return funcs
-- end

-- function modifier_shaco_haunting_presence:OnStateChanged( params )
-- 	if IsServer() then
-- 		if 
-- 	end
-- end

--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_shaco_haunting_presence:CheckState()
-- 	local state = {
-- 	[MODIFIER_STATE_XX] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_shaco_haunting_presence:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_shaco_haunting_presence:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_shaco_haunting_presence:PlayEffects()
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