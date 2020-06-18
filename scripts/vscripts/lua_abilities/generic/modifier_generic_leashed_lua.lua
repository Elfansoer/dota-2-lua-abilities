-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_generic_leashed_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_leashed_lua:IsHidden()
	return true
end

function modifier_generic_leashed_lua:IsDebuff()
	return true
end

function modifier_generic_leashed_lua:IsStunDebuff()
	return false
end

function modifier_generic_leashed_lua:IsPurgable()
	if not IsServer() then return end
	return self.purgable
end

function modifier_generic_leashed_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_leashed_lua:OnCreated( kv )
	if not IsServer() then return end
	self.parent = self:GetParent()
	--[[
	kv data (default):
		center_x/y (origin)
		radius (300)
		rooted (true)
		purgable (true)
	]]
	-- load types
	self.rooted = true
	self.purgable = true
	if kv.rooted then self.rooted = kv.rooted==1 end
	if kv.purgable then self.purgable = kv.purgable==1 end
	if self.rooted then self:SetStackCount(1) end

	-- load values
	self.radius = kv.radius or 300
	if kv.center_x and kv.center_y then
		self.center = Vector( kv.center_x, kv.center_y, 0 )
	else
		self.center = self:GetParent():GetOrigin()
	end

	-- consts
	self.max_speed = 550
	self.min_speed = 0.1
	self.max_min = self.max_speed-self.min_speed
	self.half_width = 50
end

function modifier_generic_leashed_lua:OnRefresh( kv )
	
end

function modifier_generic_leashed_lua:OnRemoved()
end

function modifier_generic_leashed_lua:OnDestroy()
	if not IsServer() then return end
	if self.endCallback then
		self.endCallback()
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_leashed_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_generic_leashed_lua:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end

	-- get data
	local parent_vector = self.parent:GetOrigin()-self.center
	local parent_direction = parent_vector:Normalized()
	local actual_distance = parent_vector:Length2D()
	local wall_distance = self.radius-actual_distance

	-- if outside of leash, destroy
	if wall_distance<(-self.half_width) then
		self:Destroy()
		return 0
	end

	-- calculate facing angle
	local parent_angle = VectorToAngles(parent_direction).y
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )

	-- calculate movespeed limit
	local limit = 0
	if wall_angle<=90 then
		-- facing outside
		if wall_distance<0 then
			-- at max radius
			limit = self.min_speed
			-- self:RemoveMotions()
		else
			-- about to max radius, interpolate
			limit = (wall_distance/self.half_width)*self.max_min + self.min_speed
		end
	end

	return limit
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_leashed_lua:CheckState()
	local state = {
		[MODIFIER_STATE_TETHERED] = self:GetStackCount()==1,
	}

	return state
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_leashed_lua:SetEndCallback( func )
	self.endCallback = func
end