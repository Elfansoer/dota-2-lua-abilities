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
test_knockback = class({})
LinkLuaModifier( "modifier_test_knockback", "test_abilities/test_knockback/modifier_test_knockback", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Ability Start
function test_knockback:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- logic
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_test_knockback", -- modifier name
		{} -- kv
	)
end