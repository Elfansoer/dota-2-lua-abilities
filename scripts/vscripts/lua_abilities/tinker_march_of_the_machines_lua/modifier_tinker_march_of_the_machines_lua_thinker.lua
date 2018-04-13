modifier_tinker_march_of_the_machines_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tinker_march_of_the_machines_lua_thinker:IsHidden()
	return true
end

function modifier_tinker_march_of_the_machines_lua_thinker:IsDebuff()
	return false
end

function modifier_tinker_march_of_the_machines_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tinker_march_of_the_machines_lua_thinker:OnCreated( kv )
	if IsServer() then
		-- references
		local duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
		
		self.speed = self:GetAbility():GetSpecialValueFor( "speed" ) -- special value
		self.distance = self:GetAbility():GetSpecialValueFor( "distance" ) -- special value
		if self:GetParent():HasScepter() then
			self.distance = self:GetAbility():GetSpecialValueFor( "distance_scepter" ) -- special value
		end

		local machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec" ) -- special value
		self.collision_radius = self:GetAbility():GetSpecialValueFor( "collision_radius" ) -- special value
		self.splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" ) -- special value
		self.splash_damage = self:GetAbility():GetAbilityDamage()

		-- generate Data
		self.projectile_name = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermaw.vpcf"
		local interval = 1/machines_per_sec
		local center = self:GetParent():GetOrigin()

		self.direction = (center-self:GetCaster():GetOrigin())
		self.direction = Vector( self.direction.x, self.direction.y, 0 ):Normalized()
		self:GetParent():SetForwardVector( self.direction )
		
		self.spawn_vector = self:GetParent():GetRightVector()

		self.center_start = center - self.direction*self.radius

		-- add duration
		self:SetDuration( duration, false )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()

		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		EmitSoundOn( sound_cast, self:GetParent() )
	end
end

function modifier_tinker_march_of_the_machines_lua_thinker:OnRefresh( kv )
	
end

function modifier_tinker_march_of_the_machines_lua_thinker:OnDestroy( kv )
	if IsServer() then
		-- effects
		local sound_cast = "Hero_Tinker.March_of_the_Machines"
		StopSoundOn( sound_cast, self:GetParent() )

		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_tinker_march_of_the_machines_lua_thinker:OnIntervalThink()
	-- generate spawn point
	local spawn = self.center_start + self.spawn_vector*RandomInt( -self.radius, self.radius )

	-- spawn machines
	local info = {
		Source = self:GetCaster(),
		Ability = self:GetAbility(),
		vSpawnOrigin = spawn,
		
	    bDeleteOnHit = true,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = self.projectile_name,
	    fDistance = self.distance,
	    fStartRadius = self.collision_radius,
	    fEndRadius =self.collision_radius,
		vVelocity = self.direction * self.speed,

		ExtraData = {
			radius = self.splash_radius,
			damage = self.splash_damage,
		}
	}
	projectile = ProjectileManager:CreateLinearProjectile(info)
end