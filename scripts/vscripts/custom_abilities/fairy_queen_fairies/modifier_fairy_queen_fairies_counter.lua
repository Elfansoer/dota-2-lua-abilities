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
modifier_fairy_queen_fairies_counter = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_fairies_counter:IsHidden()
	return false
end

function modifier_fairy_queen_fairies_counter:IsDebuff()
	return false
end

function modifier_fairy_queen_fairies_counter:IsPurgable()
	return false
end

function modifier_fairy_queen_fairies_counter:RemoveOnDeath()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_fairies_counter:OnCreated( kv )
end

function modifier_fairy_queen_fairies_counter:OnRefresh( kv )
end

function modifier_fairy_queen_fairies_counter:OnRemoved()
end

function modifier_fairy_queen_fairies_counter:OnDestroy()
end