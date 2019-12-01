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
modifier_void_spirit_aether_remnant_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_void_spirit_aether_remnant_lua:IsHidden()
	return false
end

function modifier_void_spirit_aether_remnant_lua:IsDebuff()
	return true
end

function modifier_void_spirit_aether_remnant_lua:IsStunDebuff()
	return true
end

function modifier_void_spirit_aether_remnant_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_void_spirit_aether_remnant_lua:OnCreated( kv )
	-- references

	if not IsServer() then return end
	self.target = Vector( kv.pos_x, kv.pos_y, 0 )

	-- get speed
	local dist = (self:GetParent():GetOrigin()-self.target):Length2D()
	self.speed = kv.pull/100*dist/kv.duration

	if not self:GetParent():IsHero() then
		self.speed = nil
	end

	-- issue a move command
	self:GetParent():MoveToPosition( self.target )
end

function modifier_void_spirit_aether_remnant_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_void_spirit_aether_remnant_lua:OnRemoved()
end

function modifier_void_spirit_aether_remnant_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_void_spirit_aether_remnant_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
	}

	return funcs
end

function modifier_void_spirit_aether_remnant_lua:GetModifierMoveSpeed_Absolute()
	if IsServer() then return self.speed end
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_void_spirit_aether_remnant_lua:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_void_spirit_aether_remnant_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_aether_remnant.vpcf"
end

function modifier_void_spirit_aether_remnant_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end