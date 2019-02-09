-- Created by Elfansoer
--[[
Test Results:
- GetBehavior runs on both Client and Server
- Server does not automatically update Client GUI
]]
--------------------------------------------------------------------------------
test_getbehavior = class({})
LinkLuaModifier( "modifier_test_getbehavior", "test_abilities/test_getbehavior/test_getbehavior", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
function test_getbehavior:GetBehavior()
	if self.passive then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

--------------------------------------------------------------------------------
-- Ability Start
function test_getbehavior:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_test_getbehavior", -- modifier name
		{} -- kv
	)
end

--------------------------------------------------------------------------------
modifier_test_getbehavior = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test_getbehavior:IsHidden()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test_getbehavior:OnCreated( kv )
	if IsServer() then
		self:GetAbility():MarkAbilityButtonDirty()
		self:SetDuration(0.1, false)
	end
	self:GetAbility().passive = true
end