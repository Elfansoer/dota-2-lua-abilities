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
megumin_azure_core = class({})
LinkLuaModifier( "modifier_megumin_azure_core", "custom_abilities/megumin_azure_core/modifier_megumin_azure_core", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_megumin_azure_core_passive", "custom_abilities/megumin_azure_core/modifier_megumin_azure_core_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function megumin_azure_core:Spawn()
	if not IsServer() then return end
end

function megumin_azure_core:IsStealable()
	return  false
end

--------------------------------------------------------------------------------
-- Passive Modifier
function megumin_azure_core:GetIntrinsicModifierName()
	return "modifier_megumin_azure_core_passive"
end

--------------------------------------------------------------------------------
-- Ability Start
function megumin_azure_core:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local explosion = caster:FindModifierByName( "modifier_megumin_explosion" )
	if not explosion then return end

	-- create modifier
	local modifier = caster:AddNewModifier(caster, self, "modifier_megumin_azure_core", {})
	explosion:Update( modifier )
end