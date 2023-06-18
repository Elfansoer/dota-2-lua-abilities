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
modifier_darkness_crusaders_strength = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_crusaders_strength:IsHidden()
	return true
end

function modifier_darkness_crusaders_strength:IsDebuff()
	return false
end

function modifier_darkness_crusaders_strength:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_crusaders_strength:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then return end

	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
end

function modifier_darkness_crusaders_strength:OnRefresh( kv )
	if not IsServer() then return end
	local modifier = self.parent:FindModifierByName( "modifier_darkness_crusaders_strength_buff" )
	if modifier then
		modifier:ForceRefresh()
	end
end

function modifier_darkness_crusaders_strength:OnRemoved()
end

function modifier_darkness_crusaders_strength:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_darkness_crusaders_strength:OnIntervalThink()
	local modifier = self.parent:FindModifierByName( "modifier_darkness_crusaders_strength_buff" )
	if modifier then return end

	if self.parent:PassivesDisabled() then return end

	-- check if disabled
	local hex = self.parent:IsHexed()
	local stun = self.parent:IsStunned() or self.parent:IsTaunted() or self.parent:IsFeared() or self.parent:IsCommandRestricted()
	if
		hex or
		stun or
		self.parent:IsDisarmed() or
		self.parent:IsSilenced() or
		self.parent:IsMuted() or
		self.parent:IsRooted()
	then
		self.parent:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_darkness_crusaders_strength_buff",
			{}
		)
	end
end
