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
tiny_toss_lua = class({})
LinkLuaModifier( "modifier_tiny_toss_lua", "lua_abilities/tiny_toss_lua/modifier_tiny_toss_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function tiny_toss_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function tiny_toss_lua:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function tiny_toss_lua:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return "#dota_hud_error_nothing_to_toss"
end

--------------------------------------------------------------------------------
-- Helper
function tiny_toss_lua:FindEnemies()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor( "grab_radius" )

	-- find unit around tiny
	local units = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target
	for _,unit in pairs(units) do
		local filter1 = (unit~=caster) and (not unit:IsAncient()) and (not unit:FindModifierByName( 'modifier_tiny_toss_lua' ))
		local filter2 = (unit:GetTeamNumber()==caster:GetTeamNumber()) or (not unit:IsInvisible())
		if filter1 then
			if filter2 then
				target = unit
				break
			end
		end
	end

	return target
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function tiny_toss_lua:OnAbilityPhaseInterrupted()

end
function tiny_toss_lua:OnAbilityPhaseStart()
	return self:FindEnemies()
	-- return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function tiny_toss_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	-- local point = self:GetCursorPosition()

	-- get victim
	local victim = self:FindEnemies()

	-- add modifier
	victim:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_tiny_toss_lua", -- modifier name
		{
			target = target:entindex(),
		} -- kv
	)

end