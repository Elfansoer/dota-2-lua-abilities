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
modifier_maple_atrocity = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_atrocity:IsHidden()
	return true
end

function modifier_maple_atrocity:IsDebuff()
	return false
end

function modifier_maple_atrocity:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_atrocity:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then return end
	self.unit = nil
end

function modifier_maple_atrocity:OnRefresh( kv )
end

function modifier_maple_atrocity:OnRemoved()
end

function modifier_maple_atrocity:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveNoDraw()
	-- NOTE: there's a library that does better to set up unit selection
	-- PlayerResource:SetOverrideSelectionEntity( self.parent:GetPlayerID(), self.parent )
end

function modifier_maple_atrocity:Init( unit )
	self.unit = unit
	self.parent:AddNoDraw()
	self:StartIntervalThink(0)
	-- PlayerResource:SetOverrideSelectionEntity( self.parent:GetPlayerID(), unit )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_maple_atrocity:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_maple_atrocity:OnIntervalThink()
	if self.unit then
		self.parent:SetOrigin(self.unit:GetOrigin())
	end
end