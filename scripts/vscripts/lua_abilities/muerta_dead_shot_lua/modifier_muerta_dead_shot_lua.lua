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
modifier_muerta_dead_shot_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_muerta_dead_shot_lua:IsHidden()
	return false
end

function modifier_muerta_dead_shot_lua:IsDebuff()
	return true
end

function modifier_muerta_dead_shot_lua:IsPurgable()
	return true
end

-- Optional Classifications
function modifier_muerta_dead_shot_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_muerta_dead_shot_lua:OnCreated( kv )
	self.parent = self:GetParent()

	if not IsServer() then return end

	EmitSoundOn( "Hero_Muerta.DeadShot.Fear", self.parent )
end

function modifier_muerta_dead_shot_lua:OnRefresh( kv )
end

function modifier_muerta_dead_shot_lua:OnRemoved()
end

function modifier_muerta_dead_shot_lua:OnDestroy()
	if not IsServer() then return end
	StopSoundOn( "Hero_Muerta.DeadShot.Fear", self.parent )
end

function modifier_muerta_dead_shot_lua:Init( direction )
	self.direction = direction

	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()
end


--------------------------------------------------------------------------------
-- Status Effects
function modifier_muerta_dead_shot_lua:CheckState()
	local state = {
		[MODIFIER_STATE_FEARED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_muerta_dead_shot_lua:OnIntervalThink()
	local target_pos = self.parent:GetOrigin() + self.direction * 100
	self.parent:MoveToPosition( target_pos )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_muerta_dead_shot_lua:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff.vpcf"
end

function modifier_muerta_dead_shot_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_muerta_dead_shot_lua:GetStatusEffectName()
	return "particles/units/heroes/hero_muerta/muerta_spell_fear_debuff_status.vpcf"
end

function modifier_muerta_dead_shot_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end