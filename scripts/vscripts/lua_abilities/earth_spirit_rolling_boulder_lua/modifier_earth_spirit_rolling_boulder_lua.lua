modifier_earth_spirit_rolling_boulder_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_earth_spirit_rolling_boulder_lua:IsHidden()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua:IsDebuff()
	return false
end

function modifier_earth_spirit_rolling_boulder_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_earth_spirit_rolling_boulder_lua:OnCreated( kv )
	-- references
	self.delay = self:GetAbility():GetSpecialValueFor( "delay" )
	self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
	self.distance = self:GetAbility():GetSpecialValueFor( "distance" )

	if IsServer() then
		self.direction = Vector( kv.x, kv.y, 0 )
		self.origin = self:GetParent():GetOrigin()

		-- Start interval
		self:StartIntervalThink( self.delay )

		-- effects
		self:PlayEffects()
	end
end

function modifier_earth_spirit_rolling_boulder_lua:OnRefresh( kv )	
end

function modifier_earth_spirit_rolling_boulder_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

function modifier_earth_spirit_rolling_boulder_lua:OnRemoved( kv )
	if IsServer() then
		-- effects
		if self.pre_collide then
			ParticleManager:SetParticleControl( self.effect_cast, 3, self.pre_collide )
		else
			ParticleManager:SetParticleControl( self.effect_cast, 3, self:GetParent():GetOrigin() )
		end

		local sound_loop = "Hero_EarthSpirit.RollingBoulder.Loop"
		StopSoundOn( sound_loop, self:GetParent() )

		local sound_end = "Hero_EarthSpirit.RollingBoulder.Destroy"
		EmitSoundOn( sound_end, self:GetParent() )

	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_earth_spirit_rolling_boulder_lua:CheckState()
	local state = {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_earth_spirit_rolling_boulder_lua:OnIntervalThink()
	-- apply motion controller
	if self:ApplyHorizontalMotionController() == false then
		self:Destroy()
		return
	end

	-- launch projectile
	local info = {
		Source = self:GetCaster(),
		Ability = self:GetAbility(),
		vSpawnOrigin = self:GetParent():GetAbsOrigin(),
		
	    bDeleteOnHit = true,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_BOTH,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
	    iUnitTargetType = DOTA_UNIT_TARGET_ALL,
	    
	    EffectName = "",
	    fDistance = self.distance,
	    fStartRadius = 150,
	    fEndRadius =150,
		vVelocity = self.direction * self.speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
	}
	ProjectileManager:CreateLinearProjectile(info)
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_earth_spirit_rolling_boulder_lua:UpdateHorizontalMotion( me, dt )
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

function modifier_earth_spirit_rolling_boulder_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- External Function
function modifier_earth_spirit_rolling_boulder_lua:Upgrade()
	self.speed = self:GetAbility():GetSpecialValueFor( "rock_speed" )
	self.distance = self:GetAbility():GetSpecialValueFor( "rock_distance" )
end

function modifier_earth_spirit_rolling_boulder_lua:End( vector )
	self.pre_collide = vector
	self:Destroy()
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_earth_spirit_rolling_boulder_lua:PlayEffects()
	-- Get Resources
	-- local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_rollingboulder.vpcf"
	local particle_cast = "particles/econ/items/earth_spirit/earth_spirit_ti6_boulder/espirit_ti6_rollingboulder.vpcf"
	local sound_loop = "Hero_EarthSpirit.RollingBoulder.Loop"

	-- Get Data

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false,
		false,
		-1,
		false,
		false
	)

	-- Create Sound
	EmitSoundOn( sound_loop, self:GetParent() )
end