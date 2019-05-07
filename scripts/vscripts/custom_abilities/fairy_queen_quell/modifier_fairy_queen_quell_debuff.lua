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
modifier_fairy_queen_quell_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_fairy_queen_quell_debuff:IsHidden()
	return false
end

function modifier_fairy_queen_quell_debuff:IsDebuff()
	return true
end

function modifier_fairy_queen_quell_debuff:IsStunDebuff()
	return false
end

function modifier_fairy_queen_quell_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_fairy_queen_quell_debuff:OnCreated( kv )

end

function modifier_fairy_queen_quell_debuff:OnRefresh( kv )
	
end

function modifier_fairy_queen_quell_debuff:OnRemoved()
end

function modifier_fairy_queen_quell_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_fairy_queen_quell_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}

	return state
end