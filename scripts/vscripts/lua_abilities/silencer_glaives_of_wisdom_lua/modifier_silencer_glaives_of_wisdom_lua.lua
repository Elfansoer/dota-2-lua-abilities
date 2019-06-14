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
modifier_silencer_glaives_of_wisdom_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_silencer_glaives_of_wisdom_lua:IsHidden()
	return false
end

function modifier_silencer_glaives_of_wisdom_lua:IsDebuff()
	return false
end

function modifier_silencer_glaives_of_wisdom_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_silencer_glaives_of_wisdom_lua:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "steal_range" )
	self.steal = 2

	if not IsServer() then return end

	-- create generic orb effect
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_orb_effect_lua", -- modifier name
		{  } -- kv
	)
end

function modifier_silencer_glaives_of_wisdom_lua:OnRefresh( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "steal_range" )
	self.steal = 2

	if not IsServer() then return end
end

function modifier_silencer_glaives_of_wisdom_lua:OnRemoved()
end

function modifier_silencer_glaives_of_wisdom_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_silencer_glaives_of_wisdom_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_HERO_KILLED,
	}

	return funcs
end

function modifier_silencer_glaives_of_wisdom_lua:OnHeroKilled( params )
	if not IsServer() then return end

	-- if allied, don't make them stupid
	if params.target:GetTeamNumber()==self:GetParent():GetTeamNumber() then return end

	-- if killer is parent, steal
	if params.attacker==self:GetParent() then
		self:Steal( params.target )
		return
	end

	-- if not parent, check radius
	local distance = (params.target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()

	if distance<=self.radius then
		self:Steal( params.target )
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_silencer_glaives_of_wisdom_lua:Steal( target )
	-- get steal number
	local steal = self.steal
	local target_int = target:GetBaseIntellect()
	if target_int<=1 then
		steal = 0
	elseif target_int-steal<1 then
		steal = target_int-1
	end

	-- steal
	self:GetParent():SetBaseIntellect( self:GetParent():GetBaseIntellect() + steal )
	target:SetBaseIntellect( target_int - steal )

	-- increment count
	self:SetStackCount( self:GetStackCount() + steal )

	-- overhead event
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_MANA_ADD,
		self:GetParent(),
		steal,
		nil
	)
	SendOverheadEventMessage(
		nil,
		OVERHEAD_ALERT_MANA_LOSS,
		target,
		steal,
		nil
	)
end