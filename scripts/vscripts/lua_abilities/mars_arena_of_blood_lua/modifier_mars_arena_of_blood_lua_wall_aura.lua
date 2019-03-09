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
modifier_mars_arena_of_blood_lua_wall_aura = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_arena_of_blood_lua_wall_aura:IsHidden()
	return true
end

function modifier_mars_arena_of_blood_lua_wall_aura:IsDebuff()
	return true
end

function modifier_mars_arena_of_blood_lua_wall_aura:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_arena_of_blood_lua_wall_aura:OnCreated( kv )
	if not IsServer() then return end
	-- references
	-- normal limit inner ring = radius - 200
	-- zero limit inner ring = radius - 100
	-- zero limit outer ring = radius + 100
	-- normal limit outer ring = radius + 200

	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.width = self:GetAbility():GetSpecialValueFor( "width" )
	self.parent = self:GetParent()

	self.twice_width = self.width*2
	self.aura_radius = self.radius + self.twice_width
	self.MAX_SPEED = 550
	self.MIN_SPEED = 1

	self.owner = kv.isProvidedByAura~=1

	if not self.owner then
		self.aura_origin = Vector( kv.aura_origin_x, kv.aura_origin_y, 0 )
	else
		self.aura_origin = self:GetParent():GetOrigin()
	end
end

function modifier_mars_arena_of_blood_lua_wall_aura:OnRefresh( kv )
end

function modifier_mars_arena_of_blood_lua_wall_aura:OnRemoved()
end

function modifier_mars_arena_of_blood_lua_wall_aura:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mars_arena_of_blood_lua_wall_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetModifierMoveSpeed_Limit( params )
	if not IsServer() then return end
	-- do nothing if owner
	if self.owner then return 0 end

	-- get data
	local parent_vector = self.parent:GetOrigin()-self.aura_origin
	local parent_direction = parent_vector:Normalized()

	-- calculate distance
	local actual_distance = parent_vector:Length2D()
	local wall_distance = actual_distance-self.radius
	local isInside = (wall_distance)<0
	wall_distance = math.min( math.abs( wall_distance ), self.twice_width )
	wall_distance = math.max( wall_distance, self.width ) - self.width -- clamped between 0 and width

	-- calculate facing angle
	local parent_angle = 0
	if isInside then
		parent_angle = VectorToAngles(parent_direction).y
	else
		parent_angle = VectorToAngles(-parent_direction).y
	end
	local unit_angle = self:GetParent():GetAnglesAsVector().y
	local wall_angle = math.abs( AngleDiff( parent_angle, unit_angle ) )

	-- calculate movespeed limit
	local limit = 0
	if wall_angle>90 then
		-- no limit if facing away
		limit = 0
	else
		-- interpolate between max
		limit = self:Interpolate( wall_distance/self.width, self.MIN_SPEED, self.MAX_SPEED )
	end

	return limit
end

--------------------------------------------------------------------------------
-- Helper
function modifier_mars_arena_of_blood_lua_wall_aura:Interpolate( value, min, max )
	return value*(max-min) + min
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_mars_arena_of_blood_lua_wall_aura:IsAura()
	return self.owner
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetModifierAura()
	return "modifier_mars_arena_of_blood_lua_wall_aura"
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraRadius()
	return self.aura_radius
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraDuration()
	return 0.3
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraSearchFlags()
	return 0
end

function modifier_mars_arena_of_blood_lua_wall_aura:GetAuraEntityReject( unit )
	if not IsServer() then return end

	-- check flying
	if unit:HasFlyMovementCapability() then return true end

	return false
end