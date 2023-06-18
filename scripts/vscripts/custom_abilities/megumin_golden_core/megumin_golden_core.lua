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
megumin_golden_core = class({})
LinkLuaModifier( "modifier_megumin_golden_core", "custom_abilities/megumin_golden_core/modifier_megumin_golden_core", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function megumin_golden_core:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end

function megumin_golden_core:IsStealable()
	return false
end

--------------------------------------------------------------------------------
-- Ability Start
function megumin_golden_core:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local explosion = caster:FindModifierByName( "modifier_megumin_explosion" )
	if not explosion then return end

	-- create modifier
	local modifier = caster:AddNewModifier(caster, self, "modifier_megumin_golden_core", {})
	explosion:Update( modifier )
end