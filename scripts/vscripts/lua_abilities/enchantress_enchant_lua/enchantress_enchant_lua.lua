enchantress_enchant_lua = class({})
LinkLuaModifier( "modifier_enchantress_enchant_lua", "lua_abilities/enchantress_enchant_lua/modifier_enchantress_enchant_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_enchantress_enchant_lua_slow", "lua_abilities/enchantress_enchant_lua/modifier_enchantress_enchant_lua_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
-- function enchantress_enchant_lua:CastFilterResultTarget( hTarget )
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

-- function enchantress_enchant_lua:GetCustomCastErrorTarget( hTarget )
-- 	if self:GetCaster() == hTarget then
-- 		return "#dota_hud_error_cant_cast_on_self"
-- 	end

-- 	return ""
-- end

--------------------------------------------------------------------------------
-- Ability Start
function enchantress_enchant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- add modifier based on target
	if target:IsRealHero() then
		local duration = self:GetDuration()

		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_enchantress_enchant_lua_slow", -- modifier name
			{ duration = duration } -- kv
		)

		-- dispel target
		target:Purge( true, false, false, false, false )

		-- play effects
		local sound_cast = "Hero_Enchantress.EnchantHero"
		EmitSoundOn( sound_cast, target )
	else
		local duration = self:GetSpecialValueFor("dominate_duration")

		target:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_enchantress_enchant_lua", -- modifier name
			{ duration = duration } -- kv
		)

		-- dispel target
		target:Purge( false, true, false, false, false )

		-- play effects
		local sound_cast = "Hero_Enchantress.EnchantCreep"
		EmitSoundOn( sound_cast, target )
	end

	-- play effects
	local sound_cast = "Hero_Enchantress.EnchantCast"
	EmitSoundOn( sound_cast, caster )
end