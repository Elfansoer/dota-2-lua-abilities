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
aqua_gods_blessing = class({})
LinkLuaModifier( "modifier_aqua_gods_blessing", "custom_abilities/aqua_gods_blessing/modifier_aqua_gods_blessing", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_aqua_gods_blessing_delay", "custom_abilities/aqua_gods_blessing/modifier_aqua_gods_blessing_delay", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function aqua_gods_blessing:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_aqua_gods_blessing.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_aqua_gods_blessing/aqua_gods_blessing.vpcf", context )
end

function aqua_gods_blessing:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function aqua_gods_blessing:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local search_radius = self:GetSpecialValueFor( "search_radius" )
	local total_targets = self:GetSpecialValueFor( "bonus_targets" ) + 2

	local targets = {}
	table.insert( targets, target )
	table.insert( targets, caster )

	-- find additional hero targets
	if #targets < total_targets then
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self:GetCastRange(target:GetOrigin(), target),	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
			DOTA_UNIT_TARGET_HERO,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		for _,unit in pairs(units) do
			if #targets >= total_targets then break end
			if unit~=caster and unit~=target then
				table.insert( targets, unit )
			end
		end
	end

	-- find additional unit targets
	if #targets < total_targets then
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			caster:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self:GetCastRange(target:GetOrigin(), target),	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
			DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
		for _,unit in pairs(units) do
			if #targets >= total_targets then break end
			table.insert( targets, unit )
		end
	end

	-- create buffs to targets. If number of targets is less than allowed, loop around
	for i = 0, total_targets - 1 do
		local idx = ( i % #targets ) + 1
		local unit = targets[idx]

		--[[
			NOTE: Each buff modifier needs to obtain a random number which is the same on both server and client.
			This random number must be known BEFORE buff modifier creation, since DeclareFunctions happens before OnCreated.

			The method for each target is:
			1. Create a thinker with modifier delay
			2. Generate random number on server in modifier OnCreated
			3. Use modifier transmitter to send the random number to client
			4. On client, store the number on thinker. This is because in client it is far easier to get unit handle than modifier handle.
				Thinker handle can be obtained by having thinker as buff modifier's caster parameter
			5. Start a delay, in this case 0.2s. This is to ensure client thinker gets the random number before actual buff creation
			6. Create buff modifier. The client then gets random number from thinker on step 4
		]]

		-- create a thinker which has random seed on both client and server
		local thinker = CreateModifierThinker(
			caster,
			self,
			"modifier_aqua_gods_blessing_delay",
			{duration = 1},
			caster:GetOrigin(),
			caster:GetTeamNumber(),
			false
		)
		thinker.unit = unit
	end
end