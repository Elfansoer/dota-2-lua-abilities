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
skywrath_mage_ancient_seal_lua = class({})
LinkLuaModifier( "modifier_skywrath_mage_ancient_seal_lua", "lua_abilities/skywrath_mage_ancient_seal_lua/modifier_skywrath_mage_ancient_seal_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function skywrath_mage_ancient_seal_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor( "seal_duration" )

	-- add debuff
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_skywrath_mage_ancient_seal_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- scepter effect
	if caster:HasScepter() then
		local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
		
		-- find nearby enemies
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			scepter_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		local target_2 = nil
		-- prioritize hero
		for _,enemy in pairs(enemies) do
			if enemy~=target and enemy:IsHero() then
				target_2 = enemy
				break
			end
		end

		-- no secondary hero found, find creep
		if not target_2 then
			-- 'enemies' will only have at max 1 hero (others are creeps), which would be 'target'
			target_2 = enemies[1]		-- could be nil
			if target_2==target then
				target_2 = enemies[2]	-- could be nil
			end
		end

		if target_2 then
			-- add debuff
			target_2:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_skywrath_mage_ancient_seal_lua", -- modifier name
				{ duration = duration } -- kv
			)
		end

	end
end