modifier_mirana_leap_lua_movement = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mirana_leap_lua_movement:IsHidden()
	return true
end

function modifier_mirana_leap_lua_movement:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mirana_leap_lua_movement:OnCreated( kv )
	if IsServer() then
		-- Arc movement, with parameters:
		-- - Horizontal distance
		-- - Horizontal speed
		-- - Vertical peak

		-- references
		self.distance = self:GetAbility():GetSpecialValueFor( "leap_distance" ) -- special value
		self.speed = self:GetAbility():GetSpecialValueFor( "leap_speed" ) -- special value
		self.origin = self:GetParent():GetOrigin()

		-- load data
		self.duration = self.distance/self.speed
		self.hVelocity = self.speed
		self.direction = self:GetParent():GetForwardVector()
		self.peak = 200
		
		-- sync
		self.elapsedTime = 0
		self.motionTick = {}
		self.motionTick[0] = 0
		self.motionTick[1] = 0
		self.motionTick[2] = 0

		-- vertical motion model
		-- self.gravity = -10*1000
		self.gravity = -self.peak/(self.duration*self.duration*0.125)
		self.vVelocity = (-0.5)*self.gravity*self.duration

		-- disable ability
		self:GetAbility():SetActivated( false )

		if self:ApplyVerticalMotionController() == false then 
			self:Destroy()
		end
		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
	end
end

function modifier_mirana_leap_lua_movement:OnRefresh( kv )
	
end

function modifier_mirana_leap_lua_movement:OnDestroy( kv )
	if IsServer() then
		self:GetAbility():SetActivated( true )
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_mirana_leap_lua_movement:SyncTime( iDir, dt )
	-- check if already synced
	if self.motionTick[1]==self.motionTick[2] then
		self.motionTick[0] = self.motionTick[0] + 1
		self.elapsedTime = self.elapsedTime + dt
	end

	-- sync time
	self.motionTick[iDir] = self.motionTick[0]
	
	-- end motion
	if self.elapsedTime > self.duration and self.motionTick[1]==self.motionTick[2] then
		self:Destroy()
	end
end

function modifier_mirana_leap_lua_movement:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_mirana_leap_lua_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_mirana_leap_lua_movement:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_mirana_leap_lua_movement:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end