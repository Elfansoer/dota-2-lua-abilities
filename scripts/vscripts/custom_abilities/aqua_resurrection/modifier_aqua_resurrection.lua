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
modifier_aqua_resurrection = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_resurrection:IsHidden()
	return true
end

function modifier_aqua_resurrection:IsDebuff()
	return false
end

function modifier_aqua_resurrection:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_resurrection:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- references
	self.tomb_duration = self:GetAbility():GetSpecialValueFor( "tomb_duration" )
	self.search_radius = self:GetAbility():GetSpecialValueFor( "search_radius" )

	if not IsServer() then return end

	self.tombs = {}
end

function modifier_aqua_resurrection:OnRefresh( kv )
	-- references
	self.tomb_duration = self:GetAbility():GetSpecialValueFor( "tomb_duration" )
	self.search_radius = self:GetAbility():GetSpecialValueFor( "search_radius" )
end

function modifier_aqua_resurrection:OnRemoved()
end

function modifier_aqua_resurrection:OnDestroy()
end

function modifier_aqua_resurrection:RemoveTomb( modifier )
	self.tombs[modifier] = nil
end

function modifier_aqua_resurrection:FindClosestTomb( point )
	local closest = nil
	local dist = self.search_radius
	for modifier,_ in pairs(self.tombs) do
		local distance = (point - modifier:GetParent():GetOrigin()):Length2D()
		if (distance < self.search_radius) and (distance < dist) then
			closest = modifier
			dist = distance
		end
	end

	return closest
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_aqua_resurrection:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_aqua_resurrection:OnDeath( params )
	if params.reincarnate then return end
	if (not params.unit:IsRealHero()) or params.unit:GetTeamNumber()~=self.parent:GetTeamNumber() then return end

	-- check actual real hero
	local actual_hero = params.unit:GetPlayerOwner():GetAssignedHero()
	if params.unit ~= actual_hero then return end

	-- check if has resurrection cooldown
	local cooldown_modifier = params.unit:FindModifierByName( "modifier_aqua_resurrection_cooldown" )
	if cooldown_modifier then
		cooldown_modifier:Destroy()
		return
	end

	-- create tomb
	local thinker = CreateModifierThinker(
		self.caster, 
		self.ability, 
		"modifier_aqua_resurrection_thinker",
		{duration = self.tomb_duration},
		params.unit:GetOrigin(),
		self.caster:GetTeamNumber(),
		false
	)
	local modifier = thinker:FindModifierByName( "modifier_aqua_resurrection_thinker" )
	if not modifier then return end
	modifier.hero = params.unit
	modifier.parent_modifier = self
	self.tombs[modifier] = params.unit
end