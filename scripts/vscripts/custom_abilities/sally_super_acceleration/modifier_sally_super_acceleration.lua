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
modifier_sally_super_acceleration = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_super_acceleration:IsHidden()
	return false
end

function modifier_sally_super_acceleration:IsDebuff()
	return false
end

function modifier_sally_super_acceleration:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_super_acceleration:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger_duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end

	self.enemies = {}
	self.phase_attack = false

	self:StartIntervalThink( 0 )
	self:OnIntervalThink()
end

function modifier_sally_super_acceleration:OnRefresh( kv )
	-- references
	self.move_speed = self:GetAbility():GetSpecialValueFor( "move_speed" )
	self.linger = self:GetAbility():GetSpecialValueFor( "linger_duration" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.enemies = {}
end

function modifier_sally_super_acceleration:OnRemoved()
end

function modifier_sally_super_acceleration:OnDestroy()
	if not IsServer() then return end

	local modifier = self.parent:FindModifierByName("modifier_sally_super_acceleration_buff")
	if modifier then
		modifier:SetDuration(self.linger, true)
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_super_acceleration:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,

		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

function modifier_sally_super_acceleration:GetModifierMoveSpeed_AbsoluteMin( params )
	return self.move_speed
end

function modifier_sally_super_acceleration:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_sally_super_acceleration:GetActivityTranslationModifiers()
	return "haste"
end

function modifier_sally_super_acceleration:OnAttack( params )
	if params.attacker == self.parent and not self.phase_attack then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sally_super_acceleration:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_sally_super_acceleration:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		if not self.enemies[enemy] then
			self.enemies[enemy] = true

			-- attack
			self.phase_attack = true
			self:GetCaster():PerformAttack( enemy, true, true, true, true, false, false, true)
			self.phase_attack = false
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sally_super_acceleration:GetEffectName()
	return "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
end

function modifier_sally_super_acceleration:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end