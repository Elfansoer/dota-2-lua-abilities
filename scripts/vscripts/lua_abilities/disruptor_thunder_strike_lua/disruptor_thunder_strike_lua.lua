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
disruptor_thunder_strike_lua = class({})
LinkLuaModifier( "modifier_disruptor_thunder_strike_lua", "lua_abilities/disruptor_thunder_strike_lua/modifier_disruptor_thunder_strike_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function disruptor_thunder_strike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_disruptor_thunder_strike_lua", -- modifier name
		{} -- kv
	)

	-- play effects
	local sound_cast = "Hero_Disruptor.ThunderStrike.Cast"
	EmitSoundOn( sound_cast, caster )
end