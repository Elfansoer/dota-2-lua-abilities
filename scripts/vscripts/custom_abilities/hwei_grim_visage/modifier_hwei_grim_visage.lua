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
modifier_hwei_grim_visage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_grim_visage:IsHidden()
	return false
end

function modifier_hwei_grim_visage:IsDebuff()
	return true
end

function modifier_hwei_grim_visage:IsPurgable()
	return true
end

-- Optional Classifications
function modifier_hwei_grim_visage:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_grim_visage:OnCreated( kv )
	self.parent = self:GetParent()

	if not IsServer() then return end
end

function modifier_hwei_grim_visage:OnRefresh( kv )
end

function modifier_hwei_grim_visage:OnRemoved()
end

function modifier_hwei_grim_visage:OnDestroy()
	if not IsServer() then return end
end

function modifier_hwei_grim_visage:Init( direction )
	self.direction = Vector( direction.dir_x, direction.dir_y, 0 )

	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hwei_grim_visage:CheckState()
	local state = {
		[MODIFIER_STATE_FEARED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = self.parent:IsCreep(),
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_grim_visage:OnIntervalThink()
	local target_pos = self.parent:GetOrigin() + self.direction * 100
	self.parent:MoveToPosition( target_pos )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_grim_visage:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf"
end

function modifier_hwei_grim_visage:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_hwei_grim_visage:GetStatusEffectName()
	return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf"
end

function modifier_hwei_grim_visage:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end