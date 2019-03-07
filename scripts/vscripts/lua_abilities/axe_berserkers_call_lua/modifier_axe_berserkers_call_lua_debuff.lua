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
modifier_axe_berserkers_call_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_axe_berserkers_call_lua_debuff:IsHidden()
	return false
end

function modifier_axe_berserkers_call_lua_debuff:IsDebuff()
	return true
end

function modifier_axe_berserkers_call_lua_debuff:IsStunDebuff()
	return false
end

function modifier_axe_berserkers_call_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_axe_berserkers_call_lua_debuff:OnCreated( kv )
	if IsServer() then
		-- two not working...?
		-- self:GetParent():SetAggroTarget( self:GetCaster() )
		-- self:GetParent():SetAttacking( self:GetCaster() )
		self:GetParent():SetForceAttackTarget( self:GetCaster() ) -- for creeps
		self:GetParent():MoveToTargetToAttack( self:GetCaster() ) -- for heroes
	end
end

function modifier_axe_berserkers_call_lua_debuff:OnRefresh( kv )
end

function modifier_axe_berserkers_call_lua_debuff:OnRemoved()
	if IsServer() then
		self:GetParent():SetForceAttackTarget( nil )
	end
end

function modifier_axe_berserkers_call_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_axe_berserkers_call_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_axe_berserkers_call_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end
