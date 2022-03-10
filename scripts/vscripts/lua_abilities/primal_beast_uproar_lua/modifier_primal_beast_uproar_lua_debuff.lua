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
modifier_primal_beast_uproar_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_uproar_lua_debuff:IsHidden()
	return false
end

function modifier_primal_beast_uproar_lua_debuff:IsDebuff()
	return true
end

function modifier_primal_beast_uproar_lua_debuff:IsPurgable()
	return true
end

function modifier_primal_beast_uproar_lua_debuff:GetTexture()
	return "primal_beast_uproar"
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_uproar_lua_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "move_slow_per_stack" )

	if not IsServer() then return end
	self.stack = kv.stack
	self:SetStackCount(self.stack)

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )
end

function modifier_primal_beast_uproar_lua_debuff:OnRefresh( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "move_slow_per_stack" )

	if not IsServer() then return end
	self.stack = kv.stack	
end

function modifier_primal_beast_uproar_lua_debuff:OnRemoved()
end

function modifier_primal_beast_uproar_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_primal_beast_uproar_lua_debuff:AddCustomTransmitterData()
	-- on server
	local data = {
		stack = self.stack
	}

	return data
end

function modifier_primal_beast_uproar_lua_debuff:HandleCustomTransmitterData( data )
	-- on client
	self.stack = data.stack
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_uproar_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_primal_beast_uproar_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.slow * self.stack
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_primal_beast_uproar_lua_debuff:GetStatusEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_status_effect_slow.vpcf"
end

function modifier_primal_beast_uproar_lua_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end