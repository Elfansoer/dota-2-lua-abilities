modifier_generic_knockback_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_knockback_lua:IsHidden()
	return true
end

function modifier_generic_knockback_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_knockback_lua:OnCreated( kv )
	if IsServer() then
		-- creation data (default)
			-- kv.distance (0)
			-- kv.duration (0)
			-- kv.x, kv.y, kv.z (xy:-forward vector, z:0)
			-- kv.IsStun (false)
			-- kv.damage (nil)
			-- kv.IsPurgable () // later 

		-- references
		self.distance = kv.distance or 0
		self.duration = kv.duration or 0
		if kv.x and kv.y then
			self.direction = Vector(kv.x,kv.y,0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.height = kv.z or 0
		self.stun = kv.IsStun

		-- load data
		self.origin = self:GetParent():GetOrigin()
		self.hVelocity = self.distance/self.duration
		
		-- sync
		self.elapsedTime = 0
		self.motionTick = {}
		self.motionTick[0] = 0
		self.motionTick[1] = 0
		self.motionTick[2] = 0

		-- vertical motion model
		self.gravity = -self.height/(self.duration*self.duration*0.125)
		self.vVelocity = (-0.5)*self.gravity*self.duration

		self.both = 0
		if self.z~=0 then
			self.both = self.both+1
			if self:ApplyVerticalMotionController() == false then 
				self:Destroy()
			end
		end
		if self.distance~=0 then
			self.both = self.both+1
			if self:ApplyHorizontalMotionController() == false then 
				self:Destroy()
			end
		end
	end
end

function modifier_generic_knockback_lua:OnRefresh( kv )
	
end

function modifier_generic_knockback_lua:OnDestroy( kv )
	if IsServer() then
		self:GetParent():InterruptMotionControllers( true )
	end
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_generic_knockback_lua:SyncTime( iDir, dt )
	-- check if sync is not required
	if self.both<2 then
		self.elapsedTime = self.elapsedTime + dt
		if self.elapsedTime > self.duration then
			self:Destroy()
		end
		return
	end

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

function modifier_generic_knockback_lua:UpdateHorizontalMotion( me, dt )
	self:SyncTime(1, dt)
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.hVelocity*self.elapsedTime

	-- change position
	parent:SetOrigin( self.origin + target )
end

function modifier_generic_knockback_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

function modifier_generic_knockback_lua:UpdateVerticalMotion( me, dt )
	self:SyncTime(2, dt)
	local parent = self:GetParent()

	-- set relative position
	local target = self.vVelocity*self.elapsedTime + 0.5*self.gravity*self.elapsedTime*self.elapsedTime

	-- change height
	parent:SetOrigin( Vector( parent:GetOrigin().x, parent:GetOrigin().y, self.origin.z+target ) )
end

function modifier_generic_knockback_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_knockback_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_knockback_lua:GetOverrideAnimation( params )
	if self.stun then
		return ACT_DOTA_FLAIL
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_knockback_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stun,
	}

	return state
end