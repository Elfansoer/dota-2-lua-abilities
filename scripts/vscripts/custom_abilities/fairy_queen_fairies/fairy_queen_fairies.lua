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
fairy_queen_fairies = class({})
LinkLuaModifier( "modifier_fairy_queen_fairies", "custom_abilities/fairy_queen_fairies/modifier_fairy_queen_fairies", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_fairies_counter", "custom_abilities/fairy_queen_fairies/modifier_fairy_queen_fairies_counter", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_fairies_visual", "custom_abilities/fairy_queen_fairies/modifier_fairy_queen_fairies_visual", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function fairy_queen_fairies:GetIntrinsicModifierName()
	return "modifier_fairy_queen_fairies"
end

--------------------------------------------------------------------------------
-- Ability Start
function fairy_queen_fairies:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- switch fairy modifer
	self.modifier:Switch()
end

--------------------------------------------------------------------------------
-- Init ability
function fairy_queen_fairies:Spawn()
	if not IsServer() then return end
	self:SetLevel(1)
end