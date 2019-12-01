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
void_spirit_aether_remnant_lua = class({})
LinkLuaModifier( "modifier_void_spirit_aether_remnant_lua", "lua_abilities/void_spirit_aether_remnant_lua/modifier_void_spirit_aether_remnant_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_void_spirit_aether_remnant_lua_thinker", "lua_abilities/void_spirit_aether_remnant_lua/modifier_void_spirit_aether_remnant_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function void_spirit_aether_remnant_lua:OnAbilityPhaseInterrupted()

end
function void_spirit_aether_remnant_lua:OnAbilityPhaseStart()
	-- Vector Targetting
	if not self:CheckVectorTargetPosition() then return false end
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function void_spirit_aether_remnant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local targets = self:GetVectorTargetPosition()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_void_spirit_aether_remnant_lua_thinker", -- modifier name
		{
			dir_x = targets.direction.x,
			dir_y = targets.direction.y,
		}, -- kv
		targets.init_pos,
		caster:GetTeamNumber(),
		false
	)

	-- Emit Sound
	local sound_cast = "Hero_VoidSpirit.AetherRemnant.Cast"
	EmitSoundOn( sound_cast, caster )
end