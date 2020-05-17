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
LinkLuaModifier( "modifier_monkey_king_tree_dance_lua", "lua_abilities/monkey_king_tree_dance_lua/modifier_monkey_king_tree_dance_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_lua_arc", "lua_abilities/monkey_king_tree_dance_lua/modifier_monkey_king_tree_dance_lua_arc", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_monkey_king_tree_dance_lua_passive", "lua_abilities/monkey_king_tree_dance_lua/modifier_monkey_king_tree_dance_lua_passive", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Passive Modifier
function monkey_king_tree_dance_lua:GetIntrinsicModifierName()
	return "modifier_monkey_king_tree_dance_lua_passive"
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
-- function monkey_king_tree_dance_lua:GetAOERadius()
-- 	return self:GetSpecialValueFor( "radius" )
-- end

-- function monkey_king_tree_dance_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function monkey_king_tree_dance_lua:CastFilterResultTarget( hTarget )
	-- check if has perch modifier
	if hTarget:GetClassname()~="ent_dota_tree" then return UF_FAIL_CUSTOM end

	local caster = self:GetCaster()
	if caster:HasModifier( "modifier_monkey_king_tree_dance_lua" ) then
		print("","has modifier")
		-- check if target outside range
		if (hTarget:GetOrigin()-caster:GetOrigin()):Length2D()>self:GetCastRange( hTarget:GetOrigin(), hTarget ) then
			-- error
			return UF_FAIL_CUSTOM
		end
	end

	return UF_SUCCESS
end

function monkey_king_tree_dance_lua:GetCustomCastErrorTarget( hTarget )
	-- check if has perch modifier
	local caster = self:GetCaster()
	if caster:HasModifier( "modifier_monkey_king_tree_dance_lua" ) then
		-- check if target outside range
		if (hTarget:GetOrigin()-caster:GetOrigin()):Length2D()>self:GetCastRange( hTarget:GetOrigin(), hTarget ) then
			-- error
			return "#dota_hud_error_tree_outside_range"
		end
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function monkey_king_tree_dance_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- check if from perch
	local perch = 0
	if caster:FindModifierByNameAndCaster( "modifier_monkey_king_tree_dance_lua", caster ) then
		perch = 1
	end

	-- load data
	local speed = self:GetSpecialValueFor( "leap_speed" )
	local arc_height = self:GetSpecialValueFor( "top_level_height" )
	local perch_height = self:GetSpecialValueFor( "perched_spot_height" )
	local position = target:GetOrigin()

	-- data above is fake news
	speed = 1000
	arc_height = 192
	perch_height = 256

	-- get vertical positions
	local flying_delta = 150
	local pos = target:GetOrigin()
	local height_end = GetGroundHeight( pos, caster ) + perch_height
	height_end = height_end - caster:GetOrigin().z - flying_delta

	-- add jump modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_monkey_king_tree_dance_lua_arc", -- modifier name
		{
			tree = target:entindex(),
			perch = perch,
			speed = speed,
			height_max = arc_height,
			height_end = height_end,
			x = position.x,
			y = position.y,
		} -- kv
	)

	-- play effects
	local sound_cast = "Hero_MonkeyKing.TreeJump.Cast"
	EmitSoundOn( sound_cast, caster )
end