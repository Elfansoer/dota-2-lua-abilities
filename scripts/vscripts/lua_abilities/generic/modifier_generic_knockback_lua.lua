modifier_generic_knockback_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_knockback_lua:IsHidden()
	return true
end

function modifier_generic_knockback_lua:IsPurgable()
	return false
end

function modifier_generic_knockback_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_knockback_lua:OnCreated( kv )
	if IsServer() then
		-- creation data (default)
			-- kv.distance (0)
			-- kv.height (-1)
			-- kv.duration (0)
			-- kv.direction_x, kv.direction_y, kv.direction_z (xy:-forward vector, z:0)
			-- kv.tree_destroy_radius (hull-radius), can be null if -1 
			-- kv.IsStun (false)
			-- kv.IsFlail (true)
			-- kv.IsPurgable() // later 
			-- kv.IsMultiple() // later

		-- references
		self.distance = kv.distance or 0
		self.height = kv.height or -1
		self.duration = kv.duration or 0
		if kv.direction_x and kv.direction_y then
			self.direction = Vector(kv.direction_x,kv.direction_y,0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.tree = kv.tree_destroy_radius or self:GetParent():GetHullRadius()

		if kv.IsStun then self.stun = kv.IsStun==1 else self.stun = false end
		if kv.IsFlail then self.flail = kv.IsFlail==1 else self.flail = true end

		-- check duration
		if self.duration == 0 then
			self:Destroy()
			return
		end

		-- load data
		self.parent = self:GetParent()
		self.origin = self.parent:GetOrigin()

		-- horizontal init
		self.hVelocity = self.distance/self.duration

		-- vertical init
		local half_duration = self.duration/2
		self.gravity = 2*self.height/(half_duration*half_duration)
		self.vVelocity = self.gravity*half_duration

		-- apply motion controllers
		if self.distance>0 then
			if self:ApplyHorizontalMotionController() == false then 
				self:Destroy()
				return
			end
		end
		if self.height>=0 then
			if self:ApplyVerticalMotionController() == false then 
				self:Destroy()
				return
			end
		end

		-- tell client of activity
		if self.flail then
			self:SetStackCount( 1 )
		elseif self.stun then
			self:SetStackCount( 2 )
		end
	else
		self.anim = self:GetStackCount()
		self:SetStackCount( 0 )
	end
end

function modifier_generic_knockback_lua:OnRefresh( kv )
	if not IsServer() then return end
end

function modifier_generic_knockback_lua:OnDestroy( kv )
	if not IsServer() then return end

	if not self.interrupted then
		-- destroy trees
		if self.tree>0 then
			GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.tree, true )
		end
	end

	if self.EndCallback then
		self.EndCallback( self.interrupted )
	end

	self:GetParent():InterruptMotionControllers( true )
end

--------------------------------------------------------------------------------
-- Setter
function modifier_generic_knockback_lua:SetEndCallback( func ) 
	self.EndCallback = func
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
	if self.anim==1 then
		return ACT_DOTA_FLAIL
	elseif self.anim==2 then
		return ACT_DOTA_DISABLED
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

--------------------------------------------------------------------------------
-- Motion effects
function modifier_generic_knockback_lua:UpdateHorizontalMotion( me, dt )
	local parent = self:GetParent()
	
	-- set position
	local target = self.direction*self.distance*(dt/self.duration)

	-- change position
	parent:SetOrigin( parent:GetOrigin() + target )
end

function modifier_generic_knockback_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_generic_knockback_lua:UpdateVerticalMotion( me, dt )
	-- set time
	local time = dt/self.duration

	-- change height
	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, self.vVelocity*dt ) )

	-- calculate vertical velocity
	self.vVelocity = self.vVelocity - self.gravity*dt
end

function modifier_generic_knockback_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_generic_knockback_lua:GetEffectName()
	if not IsServer() then return end
	if self.stun then
		return "particles/generic_gameplay/generic_stunned.vpcf"
	end
end

function modifier_generic_knockback_lua:GetEffectAttachType()
	if not IsServer() then return end
	return PATTACH_OVERHEAD_FOLLOW
end