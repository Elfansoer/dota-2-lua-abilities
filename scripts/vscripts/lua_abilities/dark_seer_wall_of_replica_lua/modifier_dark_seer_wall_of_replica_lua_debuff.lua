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
modifier_dark_seer_wall_of_replica_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_wall_of_replica_lua_debuff:IsHidden()
	return false
end

function modifier_dark_seer_wall_of_replica_lua_debuff:IsDebuff()
	return true
end

function modifier_dark_seer_wall_of_replica_lua_debuff:IsStunDebuff()
	return false
end

function modifier_dark_seer_wall_of_replica_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_wall_of_replica_lua_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow" )

	if not IsServer() then return end
end

function modifier_dark_seer_wall_of_replica_lua_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dark_seer_wall_of_replica_lua_debuff:OnRemoved()
end

function modifier_dark_seer_wall_of_replica_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_seer_wall_of_replica_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_dark_seer_wall_of_replica_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end