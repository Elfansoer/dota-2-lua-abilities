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

local click_enum = {
	[0] = "DOTA_CLICK_BEHAVIOR_NONE",
	[1] = "DOTA_CLICK_BEHAVIOR_MOVE",
	[2] = "DOTA_CLICK_BEHAVIOR_ATTACK",
	[3] = "DOTA_CLICK_BEHAVIOR_CAST",
	[4] = "DOTA_CLICK_BEHAVIOR_DROP_ITEM",
	[5] = "DOTA_CLICK_BEHAVIOR_DROP_SHOP_ITEM",
	[6] = "DOTA_CLICK_BEHAVIOR_DRAG",
	[7] = "DOTA_CLICK_BEHAVIOR_LEARN_ABILITY",
	[8] = "DOTA_CLICK_BEHAVIOR_PATROL",
	[9] = "DOTA_CLICK_BEHAVIOR_VECTOR_CAST",
	[10] = "DOTA_CLICK_BEHAVIOR_UNUSED",
	[11] = "DOTA_CLICK_BEHAVIOR_RADAR",
	[12] = "DOTA_CLICK_BEHAVIOR_LAST",
}

--------------------------------------------------------------------------------
modifier_generic_custom_indicator = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_custom_indicator:IsHidden()
	return true
end

function modifier_generic_custom_indicator:IsPurgable()
	return true
end

function modifier_generic_custom_indicator:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_custom_indicator:OnCreated( kv )
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.player = Entities:GetLocalPlayerController()

	if IsServer() then return end

	self.current_behavior = DOTA_CLICK_BEHAVIOR_NONE
	self.init = {
		[DOTA_CLICK_BEHAVIOR_CAST] = false,
		[DOTA_CLICK_BEHAVIOR_VECTOR_CAST] = false,
	}
	self.active_count = 0

	-- register modifier to ability
	self:GetAbility().custom_indicator = self
end

function modifier_generic_custom_indicator:OnRefresh( kv )
end

function modifier_generic_custom_indicator:OnRemoved()
end

function modifier_generic_custom_indicator:OnDestroy()
end

if IsServer() then return end
-- Only client functions below

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_generic_custom_indicator:OnIntervalThink()
	local current_behavior = self.player:GetClickBehaviors()
	local active_ability = self.player:GetActiveAbility()

	-- if cancelling cast, deactivate
	-- if no longer in current click behavior (cast vs vectorcast, remove )
	for behavior,initialized in pairs(self.init) do
		if active_ability~=self.ability or behavior~=current_behavior then
			if initialized then
				self:Deactivate( behavior )
			end
		end
	end
end

function modifier_generic_custom_indicator:Deactivate( behavior )
	self.init[behavior] = false
	if self.ability.DestroyCustomIndicator then
		self.ability:DestroyCustomIndicator( behavior )
	end
	self.active_count = self.active_count - 1
	if self.active_count < 1 then
		self:StartIntervalThink(-1)
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_custom_indicator:Register( loc )
	local behavior = self.player:GetClickBehaviors()

	if (not self.init[behavior]) then
		self.init[behavior] = true
		if self.ability.CreateCustomIndicator then
			self.ability:CreateCustomIndicator( loc, behavior )
		end
		if self.active_count < 1 then
			self:StartIntervalThink(0)
			self.active_count = self.active_count + 1
		end
	else
		if self.ability.UpdateCustomIndicator then
			self.ability:UpdateCustomIndicator( loc, behavior )
		end
	end
end