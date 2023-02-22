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
sally_mirage = class({})
LinkLuaModifier( "modifier_sally_mirage", "custom_abilities/sally_mirage/modifier_sally_mirage", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_mirage_illusion", "custom_abilities/sally_mirage/modifier_sally_mirage_illusion", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sally_mirage:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local delay = self:GetSpecialValueFor( "spawn_delay" )

	-- logic
	caster:AddNewModifier(
		caster,
		self,
		"modifier_sally_mirage",
		{duration = delay}
	)
end