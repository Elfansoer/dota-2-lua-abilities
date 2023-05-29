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
primal_beast_onslaught_lua = class({})
primal_beast_onslaught_release_lua = class({})
LinkLuaModifier( "modifier_primal_beast_onslaught_lua_charge", "lua_abilities/primal_beast_onslaught_lua/modifier_primal_beast_onslaught_lua_charge", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_primal_beast_onslaught_lua", "lua_abilities/primal_beast_onslaught_lua/modifier_primal_beast_onslaught_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function primal_beast_onslaught_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_primal_beast.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_range_finder.vpcf", context )
end

function primal_beast_onslaught_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function primal_beast_onslaught_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "chargeup_time" )

	-- add modifier
	local mod = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_onslaught_lua_charge", -- modifier name
		{ duration = duration } -- kv
	)
	-- mod.direction = direction

	self.sub = caster:FindAbilityByName( "primal_beast_onslaught_release_lua" )
	if not self.sub or self.sub:IsNull() then
		self.sub = caster:AddAbility( "primal_beast_onslaught_release_lua" )
	end
	self.sub.main = self
	self.sub:SetLevel( self:GetLevel() )

	caster:SwapAbilities(
		self:GetAbilityName(),
		self.sub:GetAbilityName(),
		false,
		true
	)

	-- set cooldown
	self.sub:UseResources( false, false, false, true )
end

function primal_beast_onslaught_lua:OnChargeFinish( interrupt )
	-- unit identifier
	local caster = self:GetCaster()

	caster:SwapAbilities(
		self:GetAbilityName(),
		self.sub:GetAbilityName(),
		true,
		false
	)

	-- load data
	local max_duration = self:GetSpecialValueFor( "chargeup_time" )
	local max_distance = self:GetSpecialValueFor( "max_distance" )
	local speed = self:GetSpecialValueFor( "charge_speed" )

	-- find charge modifier
	local charge_duration = max_duration
	local mod = caster:FindModifierByName( "modifier_primal_beast_onslaught_lua_charge" )
	if mod then
		charge_duration = mod:GetElapsedTime()

		mod.charge_finish = true
		mod:Destroy()
	end

	local distance = max_distance * charge_duration/max_duration
	local duration = distance/speed

	-- cancel if interrupted
	if interrupt then return end

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_primal_beast_onslaught_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	EmitSoundOn( "Hero_PrimalBeast.Onslaught", caster )
end

--------------------------------------------------------------------------------
-- Sub-ability
function primal_beast_onslaught_release_lua:OnSpellStart()
	self.main:OnChargeFinish( false )
end
