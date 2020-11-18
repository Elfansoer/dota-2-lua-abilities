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
modifier_dark_seer_vacuum_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_vacuum_lua:IsHidden()
	return false
end

function modifier_dark_seer_vacuum_lua:IsDebuff()
	return true
end

function modifier_dark_seer_vacuum_lua:IsStunDebuff()
	return true
end

function modifier_dark_seer_vacuum_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_vacuum_lua:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )

	if not IsServer() then return end

	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- set direction and speed
	local center = Vector( kv.x, kv.y, 0 )
	self.direction = center - self:GetParent():GetOrigin()
	self.speed = self.direction:Length2D()/self:GetDuration()

	self.direction.z = 0
	self.direction = self.direction:Normalized()

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_dark_seer_vacuum_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dark_seer_vacuum_lua:OnRemoved()
end

function modifier_dark_seer_vacuum_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )

	-- apply damage
	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_seer_vacuum_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_dark_seer_vacuum_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dark_seer_vacuum_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_dark_seer_vacuum_lua:UpdateHorizontalMotion( me, dt )
	local target = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( target )
end

function modifier_dark_seer_vacuum_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end