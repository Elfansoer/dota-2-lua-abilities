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
modifier_outworld_devourer_equilibrium_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_outworld_devourer_equilibrium_lua_buff:IsHidden()
	return false
end

function modifier_outworld_devourer_equilibrium_lua_buff:IsDebuff()
	return false
end

function modifier_outworld_devourer_equilibrium_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_outworld_devourer_equilibrium_lua_buff:OnCreated( kv )
end

function modifier_outworld_devourer_equilibrium_lua_buff:OnRefresh( kv )
end

function modifier_outworld_devourer_equilibrium_lua_buff:OnRemoved()
end

function modifier_outworld_devourer_equilibrium_lua_buff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_outworld_devourer_equilibrium_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_matter_buff.vpcf"
end

function modifier_outworld_devourer_equilibrium_lua_buff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_outworld_devourer_equilibrium_lua_buff:GetStatusEffectName()
	return "particles/status_fx/status_effect_obsidian_matter.vpcf"
end