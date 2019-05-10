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
skywrath_mage_mystic_flare_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_mystic_flare_lua_thinker", "lua_abilities/skywrath_mage_mystic_flare_lua/modifier_skywrath_mage_mystic_flare_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function skywrath_mage_mystic_flare_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_mystic_flare_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	local radius = self:GetSpecialValueFor( "radius" )

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_skywrath_mage_mystic_flare_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)

	-- play effects
	local sound_cast = "Hero_SkywrathMage.MysticFlare.Cast"
	EmitSoundOn( sound_cast, caster )

	-- scepter effect
	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
		
		-- find nearby enemies
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			point,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			scepter_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		local target = nil
		local creep = nil
		-- prioritize hero
		for _,enemy in pairs(enemies) do
			-- only enemies outside cast aoe
			if (enemy:GetOrigin()-point):Length2D()>radius then
				if enemy:IsHero() then
					target = enemy
					break
				elseif not creep then
					-- store first found creep
					creep = enemy
				end
			end
		end
		-- no secondary hero found, find creep
		if not target then
			target = creep
		end

		if target then
			-- create thinker
			CreateModifierThinker(
				caster, -- player source
				self, -- ability source
				"modifier_skywrath_mage_mystic_flare_lua_thinker", -- modifier name
				{ duration = duration }, -- kv
				target:GetOrigin(),
				caster:GetTeamNumber(),
				false
			)
		end
	end
end