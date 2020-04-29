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
modifier_underlord_atrophy_aura_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_atrophy_aura_lua:IsHidden()
	return self:GetStackCount()==0
end

function modifier_underlord_atrophy_aura_lua:IsDebuff()
	return false
end

function modifier_underlord_atrophy_aura_lua:IsStunDebuff()
	return false
end

function modifier_underlord_atrophy_aura_lua:IsPurgable()
	return false
end

function modifier_underlord_atrophy_aura_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_underlord_atrophy_aura_lua:RemoveOnDeath()
	return false
end

function modifier_underlord_atrophy_aura_lua:DestroyOnExpire()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_atrophy_aura_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.hero_bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage_from_hero" )
	self.creep_bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage_from_creep" )
	self.bonus = self:GetAbility():GetSpecialValueFor( "permanent_bonus" )
	self.duration = self:GetAbility():GetSpecialValueFor( "bonus_damage_duration" )
	self.duration_scepter = self:GetAbility():GetSpecialValueFor( "bonus_damage_duration_scepter" )

	if not IsServer() then return end

	-- create scepter modifier
	self.scepter_aura = self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_underlord_atrophy_aura_lua_scepter", -- modifier name
		{} -- kv
	)
end

function modifier_underlord_atrophy_aura_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.hero_bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage_from_hero" )
	self.creep_bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage_from_creep" )
	self.bonus = self:GetAbility():GetSpecialValueFor( "permanent_bonus" )
	self.duration = self:GetAbility():GetSpecialValueFor( "bonus_damage_duration" )
	self.duration_scepter = self:GetAbility():GetSpecialValueFor( "bonus_damage_duration_scepter" )

	if not IsServer() then return end

	-- refresh scepter modifier
	self.scepter_aura:ForceRefresh()
end

function modifier_underlord_atrophy_aura_lua:OnRemoved()
end

function modifier_underlord_atrophy_aura_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_underlord_atrophy_aura_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

function modifier_underlord_atrophy_aura_lua:OnDeath( params )
	if not IsServer() then return end
	local parent = self:GetParent()

	-- cancel if break
	if parent:PassivesDisabled() then return end

	-- not illusion
	if params.unit:IsIllusion() then return end

	-- check if has modifier
	if not params.unit:FindModifierByNameAndCaster( "modifier_underlord_atrophy_aura_lua_debuff", parent ) then return end

	local hero = params.unit:IsHero()
	local bonus
	if hero then
		bonus = self.hero_bonus
	else
		bonus = self.creep_bonus
	end

	-- set duration
	local duration
	if parent:HasScepter() then
		duration = self.duration_scepter
	else
		duration = self.duration
	end

	-- add stack
	self:SetStackCount( self:GetStackCount() + bonus )

	-- add expire modifier
	local modifier = parent:AddNewModifier(
		parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_underlord_atrophy_aura_lua_stack", -- modifier name
		{ duration = duration } -- kv
	)
	modifier.parent = self
	modifier.bonus = bonus

	-- add duration
	self:SetDuration( self.duration, true )

	-- add permanent bonus if hero
	if hero then
		parent:AddNewModifier(
			parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_underlord_atrophy_aura_lua_permanent_stack", -- modifier name
			{ bonus = self.bonus } -- kv
		)
	end
end

function modifier_underlord_atrophy_aura_lua:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end

--------------------------------------------------------------------------------
-- helper
function modifier_underlord_atrophy_aura_lua:RemoveStack( value )
	self:SetStackCount( self:GetStackCount() - value )
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_underlord_atrophy_aura_lua:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_underlord_atrophy_aura_lua:GetModifierAura()
	return "modifier_underlord_atrophy_aura_lua_debuff"
end

function modifier_underlord_atrophy_aura_lua:GetAuraRadius()
	return self.radius
end

function modifier_underlord_atrophy_aura_lua:GetAuraDuration()
	return 0.5
end

function modifier_underlord_atrophy_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_underlord_atrophy_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_underlord_atrophy_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_underlord_atrophy_aura_lua:IsAuraActiveOnDeath()
	return false
end

function modifier_underlord_atrophy_aura_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		if hEntity==self:GetCaster() then return true end
	end

	return false
end