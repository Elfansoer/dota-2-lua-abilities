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
underlord_dark_rift_lua = class({})
LinkLuaModifier( "modifier_underlord_dark_rift_lua", "lua_abilities/underlord_dark_rift_lua/modifier_underlord_dark_rift_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function underlord_dark_rift_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- search for closest target if it is a point
	if not target then
		local targets = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			point,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
			DOTA_UNIT_TARGET_BUILDING + DOTA_UNIT_TARGET_CREEP,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
			FIND_CLOSEST,	-- int, order filter
			false	-- bool, can grow cache
		)

		if #targets>0 then target = targets[1] end
	end

	-- if, somehow, for an exceptional miracle, there is still no target, then do nothing. This should be done on ability phase, but whatever
	if not target then return end

	-- load data
	local duration = self:GetSpecialValueFor( "teleport_delay" )

	-- add modifier to target
	local modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_underlord_dark_rift_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- check sister ability
	local ability = caster:FindAbilityByName( "underlord_cancel_dark_rift_lua" )
	if not ability then
		ability = caster:AddAbility( "underlord_cancel_dark_rift_lua" )
		ability:SetStolen( true )
	end

	-- check ability level
	ability:SetLevel( 1 )

	-- give info about modifier
	ability.modifier = modifier

	-- switch ability layout
	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)
end

--------------------------------------------------------------------------------
-- Sub Ability
--------------------------------------------------------------------------------
underlord_cancel_dark_rift_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function underlord_cancel_dark_rift_lua:OnSpellStart()
	-- kill modifier
	self.modifier:Cancel()
	self.modifier = nil
end