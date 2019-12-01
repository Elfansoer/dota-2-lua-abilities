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
modifier_generic_ring_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_ring_lua:IsHidden()
	return true
end

function modifier_generic_ring_lua:IsDebuff()
	return false
end

function modifier_generic_ring_lua:IsStunDebuff()
	return false
end

function modifier_generic_ring_lua:IsPurgable()
	return false
end

function modifier_generic_ring_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_ring_lua:OnCreated( kv )
	-- kv.start_radius (0)
	-- kv.end_radius (0)
	-- kv.width (100)
	-- kv.speed (0)

	-- default 0
	-- kv.target_team
	-- kv.target_type
	-- kv.target_flags

	-- modifier:SetCallback( function( unit ) ... end ) 

	if not IsServer() then return end

	-- references
	self.start_radius = kv.start_radius or 0
	self.end_radius = kv.end_radius or 0
	self.width = kv.width or 100
	self.speed = kv.speed or 0

	self.target_team = kv.target_team or 0
	self.target_type = kv.target_type or 0
	self.target_flags = kv.target_flags or 0

	self.targets = {}
end

function modifier_generic_ring_lua:OnRemoved()
end

function modifier_generic_ring_lua:OnDestroy()
end

function modifier_generic_ring_lua:SetCallback( callback )
	self.Callback = callback

	-- Start interval
	self:StartIntervalThink( 0.03 )
	self:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_ring_lua:OnIntervalThink()
	local radius = self.start_radius + self.speed * self:GetElapsedTime()
	if radius>self.end_radius then
		self:Destroy()
		return
	end

	-- Find targets in ring
	local targets = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.target_team,	-- int, team filter
		self.target_type,	-- int, type filter
		self.target_flags,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,target in pairs(targets) do
		-- only check for targets that have not been hit, and within width
		if not self.targets[target] and (target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()>(radius-self.width) then
			self.targets[target] = true

			-- do something
			self.Callback( target )
		end
	end
end