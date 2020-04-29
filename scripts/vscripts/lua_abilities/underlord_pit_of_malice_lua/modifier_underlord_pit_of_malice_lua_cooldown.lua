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
modifier_underlord_pit_of_malice_lua_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_pit_of_malice_lua_cooldown:IsHidden()
	return true
end

function modifier_underlord_pit_of_malice_lua_cooldown:IsDebuff()
	return true
end

function modifier_underlord_pit_of_malice_lua_cooldown:IsPurgable()
	return false
end

function modifier_underlord_pit_of_malice_lua_cooldown:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_pit_of_malice_lua_cooldown:OnCreated( kv )

end

function modifier_underlord_pit_of_malice_lua_cooldown:OnRefresh( kv )
	
end

function modifier_underlord_pit_of_malice_lua_cooldown:OnRemoved()
end

function modifier_underlord_pit_of_malice_lua_cooldown:OnDestroy()
end