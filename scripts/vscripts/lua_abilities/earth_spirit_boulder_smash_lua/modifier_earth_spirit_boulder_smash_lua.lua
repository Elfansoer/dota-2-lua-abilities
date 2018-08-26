modifier_earth_spirit_boulder_smash_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_boulder_smash_lua:IsHidden()
	return false
end

function modifier_earth_spirit_boulder_smash_lua:IsDebuff()
	return true
end

function modifier_earth_spirit_boulder_smash_lua:IsStunDebuff()
	return false
end

function modifier_earth_spirit_boulder_smash_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_boulder_smash_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" ) -- special value
		self.damage = self:GetAbility():GetSpecialValueFor( "rock_damage" ) -- special value

		self.origin = self:GetParent():GetOrigin()

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end
	end
end

function modifier_earth_spirit_boulder_smash_lua:OnRefresh( kv )
	if IsServer() then
		-- references
		self.distance = kv.r
		self.direction = Vector(kv.x,kv.y,0):Normalized()
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" ) -- special value
		self.damage = self:GetAbility():GetSpecialValueFor( "rock_damage" ) -- special value

		self.origin = self:GetParent():GetOrigin()

		-- apply motion controller
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
	end	
end

function modifier_earth_spirit_boulder_smash_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_earth_spirit_boulder_smash_lua:UpdateHorizontalMotion( me, dt )
	local pos = self:GetParent():GetOrigin()
	
	-- stop if already past distance
	if (pos-self.origin):Length2D()>=self.distance then
		self:Destroy()
		return
	end

	-- set position
	local target = pos + self.direction * (self.speed*dt)

	-- change position
	self:GetParent():SetOrigin( target )
end

function modifier_earth_spirit_boulder_smash_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_earth_spirit_boulder_smash_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_earth_spirit_boulder_smash_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_earth_spirit_boulder_smash_lua:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_STUNNED] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_earth_spirit_boulder_smash_lua:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_earth_spirit_boulder_smash_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_earth_spirit_boulder_smash_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_earth_spirit_boulder_smash_lua:PlayEffects()
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