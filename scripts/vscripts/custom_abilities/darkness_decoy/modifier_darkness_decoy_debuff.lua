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
modifier_darkness_decoy_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_darkness_decoy_debuff:IsHidden()
	return false
end

function modifier_darkness_decoy_debuff:IsDebuff()
	return true
end

function modifier_darkness_decoy_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_darkness_decoy_debuff:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	if not IsServer() then return end
end

function modifier_darkness_decoy_debuff:OnRefresh( kv )
end

function modifier_darkness_decoy_debuff:OnRemoved()
end

function modifier_darkness_decoy_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_darkness_decoy_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_darkness_decoy_debuff:GetOverrideAnimation( params )
	if self.caster:IsStunned() then
		return ACT_DOTA_DISABLED
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_darkness_decoy_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.caster:IsStunned(),
		[MODIFIER_STATE_ROOTED] = self.caster:IsRooted(),
		[MODIFIER_STATE_DISARMED] = self.caster:IsDisarmed(),
		[MODIFIER_STATE_SILENCED] = self.caster:IsSilenced(),
		[MODIFIER_STATE_MUTED] = self.caster:IsMuted(),
		[MODIFIER_STATE_PASSIVES_DISABLED] = self.caster:PassivesDisabled(),
	}

	return state
end