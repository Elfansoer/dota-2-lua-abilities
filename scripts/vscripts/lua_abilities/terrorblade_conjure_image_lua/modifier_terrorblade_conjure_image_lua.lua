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
local MODIFIER_PRIORITY_MONKAGIGA_EXTEME_HYPER_ULTRA_REINFORCED_V9 = 10001

--------------------------------------------------------------------------------
modifier_terrorblade_conjure_image_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_terrorblade_conjure_image_lua:IsHidden()
	return true
end

function modifier_terrorblade_conjure_image_lua:IsDebuff()
	return false
end

function modifier_terrorblade_conjure_image_lua:IsStunDebuff()
	return false
end

function modifier_terrorblade_conjure_image_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_terrorblade_conjure_image_lua:OnCreated( kv )
	if not IsServer() then return end
end

function modifier_terrorblade_conjure_image_lua:OnRefresh( kv )
	
end

function modifier_terrorblade_conjure_image_lua:OnRemoved()
end

function modifier_terrorblade_conjure_image_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_terrorblade_conjure_image_lua:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf"
end

function modifier_terrorblade_conjure_image_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_terrorblade_conjure_image_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_terrorblade_reflection.vpcf"
end

function modifier_terrorblade_conjure_image_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_MONKAGIGA_EXTEME_HYPER_ULTRA_REINFORCED_V9
end