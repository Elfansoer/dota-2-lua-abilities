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
	local duration = self:GetSpecialValueFor("duration")

	-- create thinker
	self.thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_skywrath_mage_mystic_flare_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
	self.thinker = self.thinker:FindModifierByName("modifier_skywrath_mage_mystic_flare_lua_thinker")

	-- play effects
	local sound_cast = "Hero_SkywrathMage.MysticFlare.Cast"
	EmitSoundOn( sound_cast, caster )
end