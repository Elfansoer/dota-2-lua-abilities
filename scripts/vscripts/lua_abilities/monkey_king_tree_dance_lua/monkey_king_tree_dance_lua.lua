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
monkey_king_tree_dance_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_lua", "lua_abilities/monkey_king_tree_dance_lua/modifier_monkey_king_tree_dance_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_lua_passive", "lua_abilities/monkey_king_tree_dance_lua/modifier_monkey_king_tree_dance_lua_passive", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Passive Modifier
function monkey_king_tree_dance_lua:GetIntrinsicModifierName()
	return "modifier_monkey_king_tree_dance_lua_passive"
end

--------------------------------------------------------------------------------
-- Ability Start
function monkey_king_tree_dance_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local speed = self:GetSpecialValueFor( "leap_speed" )
	local arc_height = self:GetSpecialValueFor( "top_level_height" )
	local perch_height = self:GetSpecialValueFor( "perched_spot_height" )
	local position = target:GetOrigin()

	-- data above is fake news
	local perch_height = 256
	local speed = 1000
	local height = 192
	local distance = (target:GetOrigin()-caster:GetOrigin()):Length2D()

	-- check if from perch
	local perch = 0
	if caster:FindModifierByNameAndCaster( "modifier_monkey_king_tree_dance_lua", caster ) then
		perch = 1
	end

	-- jump
	local arc = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			target_x = target:GetOrigin().x,
			target_y = target:GetOrigin().y,
			distance = distance,
			speed = speed,
			height = height,
			fix_end = false,
			fix_height = false,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
			start_offset = perch_height*perch,
			end_offset = perch_height,
		} -- kv
	)
	arc:SetEndCallback(function()
		-- add perch modifier
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_monkey_king_tree_dance_lua", -- modifier name
			{
				tree = target:entindex(),
			} -- kv
		)
	end)

	-- set spring ability as active
	if not self.spring then
		self.spring = self:GetCaster():FindAbilityByName( 'monkey_king_primal_spring_lua' )
	end
	if self.spring then
		self.spring:SetActivated( true )
	end

	-- play effects
	self:PlayEffects( arc )
end

--------------------------------------------------------------------------------
-- Ability Events
function monkey_king_tree_dance_lua:OnUpgrade()
	-- find primal spring ability
	if not self.spring then
		self.spring = self:GetCaster():FindAbilityByName( 'monkey_king_primal_spring_lua' )
	end
	if not self.spring then return end

	-- level up
	self.spring:SetLevel( self:GetLevel() )

	-- check perch modifier
	local modifier = self:GetCaster():FindModifierByNameAndCaster( 'modifier_monkey_king_tree_dance_lua', self:GetCaster() )
	if not modifier then
		self.spring:SetActivated( false )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function monkey_king_tree_dance_lua:PlayEffects( modifier )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf"
	local sound_cast = "Hero_MonkeyKing.TreeJump.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- buff particle
	modifier:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end