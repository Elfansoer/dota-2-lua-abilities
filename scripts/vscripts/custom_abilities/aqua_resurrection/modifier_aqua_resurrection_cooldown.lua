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
modifier_aqua_resurrection_cooldown = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_resurrection_cooldown:IsHidden()
	return false
end

function modifier_aqua_resurrection_cooldown:IsDebuff()
	return false
end

function modifier_aqua_resurrection_cooldown:IsPurgable()
	return false
end

function modifier_aqua_resurrection_cooldown:RemoveOnDeath()
	return false
end