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
modifier_aqua_resurrection_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_aqua_resurrection_thinker:IsHidden()
	return false
end

function modifier_aqua_resurrection_thinker:IsDebuff()
	return false
end

function modifier_aqua_resurrection_thinker:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_aqua_resurrection_thinker:OnCreated( kv )
	if not IsServer() then return end
	self:StartIntervalThink(0.5)
end

function modifier_aqua_resurrection_thinker:OnRefresh( kv )
end

function modifier_aqua_resurrection_thinker:OnRemoved()
end

function modifier_aqua_resurrection_thinker:OnDestroy()
	if not IsServer() then return end
	self.parent_modifier:RemoveTomb( self )
	UTIL_Remove(self:GetParent())
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_aqua_resurrection_thinker:OnIntervalThink()
	if self.hero and (not self.hero:IsNull()) and self.hero:IsAlive() then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_aqua_resurrection_thinker:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_aqua_resurrection_thinker:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end