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
modifier_fairy_queen_fairies = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_fairies:IsHidden()
	return false
end

function modifier_fairy_queen_fairies:IsDebuff()
	return false
end

function modifier_fairy_queen_fairies:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_fairies:OnCreated( kv )
	if not IsServer() then return end
	-- set up modifer
	local ability = self:GetAbility()
	ability.modifier = self

	-- create modifier for fairy info
	self.counter = self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_fairy_queen_fairies_counter", -- modifier name
		{} -- kv
	)

	-- get references
	self.max_fairies = self:GetAbility():GetSpecialValueFor( "max_fairies" )

	-- stored data
	self.fairies_used = 1
	self.counter:SetStackCount( self.fairies_used )

	-- set stack count
	self:SetStackCount( self.max_fairies )

	-- create visual
	self.fairies_visual = self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_fairy_queen_fairies_visual", -- modifier name
		{} -- kv
	)
end

function modifier_fairy_queen_fairies:OnRefresh( kv )
	
end

function modifier_fairy_queen_fairies:OnRemoved()
end

function modifier_fairy_queen_fairies:OnDestroy()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_fairy_queen_fairies:Switch()
	self.fairies_used = self.fairies_used + 1
	if self.fairies_used>self.max_fairies then
		self.fairies_used = 1
	end
	self.counter:SetStackCount( self.fairies_used )
end

function modifier_fairy_queen_fairies:GetFairies()
	-- set return value
	local ret = self.fairies_used

	-- reduce remaining fairies
	self:SetStackCount( self:GetStackCount()-self.fairies_used )
	self:CalculateCharge()

	return ret,self.fairies_visual:GetFairies( ret )
end

-- recalculate fairies charges
function modifier_fairy_queen_fairies:CalculateCharge()
	if self:GetStackCount()>=self.max_fairies then
		self:SetStackCount( self.max_fairies )
		
		-- stop charging
		self:SetDuration( -1, true )
		self:StartIntervalThink( -1 )
	else
		-- if not charging
		if self:GetRemainingTime() <= 0.05 then
			-- get charge time
			local charge_time = self:GetAbility():GetSpecialValueFor( "replenish_time" )

			-- get reduction from ultimate
			local reduction = 0
			local ability = self:GetCaster():FindAbilityByName( "fairy_queen_royal_decree" )
			if ability then
				reduction = ability:GetSpecialValueFor( "cooldown_reduction" )
			end
			charge_time = charge_time - reduction

			-- start charging
			self:StartIntervalThink( charge_time )
			self:SetDuration( charge_time, true )
		end
	end
end

-- Refresh charges
function modifier_fairy_queen_fairies:Refresh()
	self:SetStackCount( self.max_fairies )
	self.fairies_visual:SetFairies( self:GetStackCount() )
	self:CalculateCharge()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_fairy_queen_fairies:OnIntervalThink()
	self:IncrementStackCount()
	self.fairies_visual:SetFairies( self:GetStackCount() )
	self:CalculateCharge()
end