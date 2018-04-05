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
		-- references
		self.distance = self:GetAbility():GetSpecialValueFor( "leap_distance" ) -- special value
		self.speed = self:GetAbility():GetSpecialValueFor( "leap_speed" ) -- special value

		-- load data
		self.direction = self:GetParent():GetForwardVector()
		self.duration = self.distance/self.speed
		self.origin = self:GetParent():GetOrigin()
		self.hVelocity = self.speed
		self.elapsedTime = 0

		-- vertical motion model
		self.gravity = -10
		self.vVelocity = (-0.5)*self.gravity*self.duration

		for k,v in pairs(self.BaseClass) do
			print(k,v)
		end

		if self:ApplyHorizontalMotionController() == false then 
			self:Destroy()
		end
		if self:ApplyVerticalMotionController() == false then 
			self:Destroy()
		end
	end
end

function modifier_mirana_leap_lua_movement:OnRefresh( kv )
	
end

function modifier_mirana_leap_lua_movement:OnDestroy( kv )
end

--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_mirana_leap_lua_movement:CheckState()
-- 	local state = {
-- 	[MODIFIER_STATE_XX] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_mirana_leap_lua_movement:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_mirana_leap_lua_movement:SyncTime( bHorizon )

end

function modifier_mirana_leap_lua_movement:UpdateHorizontalMotion( me, dt )
	print("horizontal")
	local parent = self:GetParent()
	
	local stop = false
	if self.elapsedTime>=self.duration then
		FindClearSpaceForUnit( parent, parent:GetOrigin(), true )
		
		stop = true
		self:Destroy()
	end
	
	self.elapsedTime = self.elapsedTime + dt

	-- change position
	local target = self.origin + self.direction*self.hVelocity*self.elapsedTime

	if not stop then
		parent:SetOrigin( target )
	end
end

function modifier_mirana_leap_lua_movement:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_mirana_leap_lua_movement:UpdateVerticalMotion( me, dt )
	print("vertical")
end