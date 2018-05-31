invoker_sun_strike_lua = class({})
LinkLuaModifier( "modifier_invoker_sun_strike_lua_thinker", "lua_abilities/invoker_sun_strike_lua/modifier_invoker_sun_strike_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function invoker_sun_strike_lua:GetAOERadius()
	return self:GetSpecialValueFor( "area_of_effect" )
end

-- Commented out for Cataclysm talent when available
--------------------------------------------------------------------------------
-- function invoker_sun_strike_lua:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Cast Filter
-- function invoker_sun_strike_lua:CastFilterResultTarget( hTarget )
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

-- function invoker_sun_strike_lua:GetCustomCastErrorTarget( hTarget )
-- 	if self:GetCaster() == hTarget then
-- 		return "#dota_hud_error_cant_cast_on_self"
-- 	end

-- 	return ""
-- end

--------------------------------------------------------------------------------
-- Ability Start
function invoker_sun_strike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- get values
	local delay = self:GetSpecialValueFor("delay")
	local vision_distance = self:GetSpecialValueFor("vision_distance")
	local vision_duration = self:GetSpecialValueFor("vision_duration")

	-- create modifier thinker
	CreateModifierThinker(
		caster,
		self,
		"modifier_invoker_sun_strike_lua_thinker",
		{ duration = delay },
		point,
		caster:GetTeamNumber(),
		false
	)

	-- create vision
	AddFOWViewer( caster:GetTeamNumber(), point, vision_distance, vision_duration, false )
end