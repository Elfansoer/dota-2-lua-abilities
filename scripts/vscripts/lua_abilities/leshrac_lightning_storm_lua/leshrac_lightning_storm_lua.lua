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
leshrac_lightning_storm_lua = class({})
LinkLuaModifier( "modifier_leshrac_lightning_storm_lua", "lua_abilities/leshrac_lightning_storm_lua/modifier_leshrac_lightning_storm_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_leshrac_lightning_storm_lua_thinker", "lua_abilities/leshrac_lightning_storm_lua/modifier_leshrac_lightning_storm_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function leshrac_lightning_storm_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- create thinker
	local thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_leshrac_lightning_storm_lua_thinker", -- modifier name
		{  }, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	local modifier = thinker:FindModifierByName( "modifier_leshrac_lightning_storm_lua_thinker" )
	modifier:Cast( target )
end