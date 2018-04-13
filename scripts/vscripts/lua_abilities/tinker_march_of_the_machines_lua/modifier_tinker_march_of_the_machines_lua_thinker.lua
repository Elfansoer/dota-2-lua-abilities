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
		self.duration = self:GetAbility():GetSpecialValueFor( "duration" ) -- special value
		self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) -- special value
		
		self.distance = self:GetAbility():GetSpecialValueFor( "distance" ) -- special value
		self.distance_scepter = self:GetAbility():GetSpecialValueFor( "distance_scepter" ) -- special value

		self.machines_per_sec = self:GetAbility():GetSpecialValueFor( "machines_per_sec`" ) -- special value
		self.collision_radius = self:GetAbility():GetSpecialValueFor( "collision_radius" ) -- special value
		self.splash_radius = self:GetAbility():GetSpecialValueFor( "splash_radius" ) -- special value
		self.splash_damage = self:GetAbility():GetAbilityDamage()

		-- generate Data
		local interval = 1/self.machines_per_sec
		local center = self:GetParent():GetOrigin()
		local direction = (center-self:GetCaster():GetOrigin())
		direction = Vector( direction.x, direction.y, 0 ):Normalized()
		-- spawn_vector = todo here
		local center_start = center - direction*self.radius

		-- add dummy ability

		-- add duration
		self:SetDuration( self.duration, false )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()
	end
end

function modifier_tinker_march_of_the_machines_lua_thinker:OnRefresh( kv )
	
end

function modifier_tinker_march_of_the_machines_lua_thinker:OnDestroy( kv )
	if IsServer() then
		UTIL_Remove( self:GeParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_tinker_march_of_the_machines_lua_thinker:OnIntervalThink()
end