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
modifier_outworld_devourer_arcane_orb_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_outworld_devourer_arcane_orb_lua:IsHidden()
	return false
end

function modifier_outworld_devourer_arcane_orb_lua:IsDebuff()
	return self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber()
end

function modifier_outworld_devourer_arcane_orb_lua:IsStunDebuff()
	return false
end

function modifier_outworld_devourer_arcane_orb_lua:IsPurgable()
	return false
end

function modifier_outworld_devourer_arcane_orb_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_outworld_devourer_arcane_orb_lua:OnCreated( kv )
	-- reduce intel if debuff, add if buff
	self.debuff = self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber()
	self.mult = 1
	if self.debuff then
		self.mult = -1
	end

	if not IsServer() then return end

	self:AddStack( kv.steal, kv.duration )
end

function modifier_outworld_devourer_arcane_orb_lua:OnRefresh( kv )
	if not IsServer() then return end

	self:AddStack( kv.steal, kv.duration )
end

function modifier_outworld_devourer_arcane_orb_lua:OnRemoved()
end

function modifier_outworld_devourer_arcane_orb_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_outworld_devourer_arcane_orb_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end

function modifier_outworld_devourer_arcane_orb_lua:GetModifierBonusStats_Intellect()
	return self.mult * self:GetStackCount()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_outworld_devourer_arcane_orb_lua:AddStack( value, duration )
	-- set stack
	self:SetStackCount( self:GetStackCount() + value )

	-- add stack modifier
	local modifier = self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_outworld_devourer_arcane_orb_lua_stack", -- modifier name
		{
			duration = duration,
			stack = value,
		} -- kv
	)

	-- set stack parent modifier as this
	modifier.modifier = self

	-- reduce some mana because of stat loss
	if self.debuff then
		self:GetParent():Script_ReduceMana( value * 12, self:GetAbility() )
	end
end

function modifier_outworld_devourer_arcane_orb_lua:RemoveStack( value )
	-- set stack
	self:SetStackCount( self:GetStackCount() - value )

	-- restore some mana because of stat gain
	if self.debuff then
		self:GetParent():GiveMana( value * 12 )
	end

	-- if reach zero, destroy
	if self:GetStackCount()<=0 then
		self:Destroy()
	end
end