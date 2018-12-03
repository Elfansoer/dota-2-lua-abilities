-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Break behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
huskar_life_break_lua = class({})
LinkLuaModifier( "modifier_huskar_life_break_lua", "lua_abilities/huskar_life_break_lua/modifier_huskar_life_break_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_huskar_life_break_lua_buff", "lua_abilities/huskar_life_break_lua/modifier_huskar_life_break_lua_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_huskar_life_break_lua_debuff", "lua_abilities/huskar_life_break_lua/modifier_huskar_life_break_lua_debuff", LUA_MODIFIER_MOTION_NONE )
local tempTable = require("util/tempTable")

--------------------------------------------------------------------------------
-- Custom KV
function huskar_life_break_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

-- --------------------------------------------------------------------------------
-- -- Ability Cast Filter
-- function huskar_life_break_lua:CastFilterResultTarget( hTarget )
-- 	if self:GetCaster() == hTarget then
-- 		return UF_FAIL_CUSTOM
-- 	end

-- 	local nResult = UnitFilter(
-- 		hTarget,
-- 		DOTA_UNIT_TARGET_TEAM_BOTH,
-- 		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
-- 		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
-- 		self:GetCaster():GetTeamNumber()
-- 	)
-- 	if nResult ~= UF_SUCCESS then
-- 		return nResult
-- 	end

-- 	return UF_SUCCESS
-- end

-- function huskar_life_break_lua:GetCustomCastErrorTarget( hTarget )
-- 	if self:GetCaster() == hTarget then
-- 		return "#dota_hud_error_cant_cast_on_self"
-- 	end

-- 	return ""
-- end

--------------------------------------------------------------------------------
-- Ability Start
function huskar_life_break_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = 5

	-- add modifiers
	local tgt = tempTable:AddATValue( target )
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_huskar_life_break_lua", -- modifier name
		{
			target = tgt,
		} -- kv
	)
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_huskar_life_break_lua_buff", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Huskar.Life_Break"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- function huskar_life_break_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end