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
modifier_mars_spear_of_mars_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_spear_of_mars_lua:IsHidden()
	return false
end

function modifier_mars_spear_of_mars_lua:IsDebuff()
	return true
end

function modifier_mars_spear_of_mars_lua:IsStunDebuff()
	return true
end

function modifier_mars_spear_of_mars_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_spear_of_mars_lua:OnCreated( kv )
	-- references
	self.ability = self:GetAbility()

	if IsServer() then
		self.projectile = kv.projectile

		-- face towards
		self:GetParent():FaceTowards( self.ability.projectiles[kv.projectile].init_pos )

		-- try apply
		if self:ApplyHorizontalMotionController() == false then
			self:Destroy()
		end
	end
end

function modifier_mars_spear_of_mars_lua:OnRefresh( kv )
	
end

function modifier_mars_spear_of_mars_lua:OnRemoved()
	if not IsServer() then return end

	-- Compulsory interrupt
	self:GetParent():InterruptMotionControllers( false )
end

function modifier_mars_spear_of_mars_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mars_spear_of_mars_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_mars_spear_of_mars_lua:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_mars_spear_of_mars_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_mars_spear_of_mars_lua:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_mars_spear_of_mars_lua:UpdateHorizontalMotion( me, dt )
	-- check projectile data
	if not self.ability.projectiles[self.projectile] then
		self:Destroy()
		return
	end

	-- get location
	local loc = self.ability.projectiles[self.projectile].location

	-- move parent to projectile location
	self:GetParent():SetOrigin( loc )
end

function modifier_mars_spear_of_mars_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self:Destroy()
	end
end