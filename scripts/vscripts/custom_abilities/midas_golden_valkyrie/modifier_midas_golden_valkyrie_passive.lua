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
modifier_midas_golden_valkyrie_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_midas_golden_valkyrie_passive:IsHidden()
	return false
end

function modifier_midas_golden_valkyrie_passive:IsPurgable()
	return false
end

function modifier_midas_golden_valkyrie_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_midas_golden_valkyrie_passive:OnCreated( kv )
end

function modifier_midas_golden_valkyrie_passive:OnRefresh( kv )
	
end

function modifier_midas_golden_valkyrie_passive:OnRemoved()
end

function modifier_midas_golden_valkyrie_passive:OnDestroy()
end
