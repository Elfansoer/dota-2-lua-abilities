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
modifier_maple_devour_crystal = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_devour_crystal:IsHidden()
	return false
end

function modifier_maple_devour_crystal:IsDebuff()
	return false
end

function modifier_maple_devour_crystal:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_maple_devour_crystal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_devour_crystal:OnCreated( kv )
	if not IsServer() then return end

	self.mana_bonus = math.ceil(kv.mana)
	self:SetStackCount(self.mana_bonus)

	self.intrinsic = self:GetParent():FindModifierByName("modifier_maple_devour")
	if self.intrinsic then
		self.intrinsic:AddCrystal( self )
	end
end

function modifier_maple_devour_crystal:OnRefresh( kv )
end

function modifier_maple_devour_crystal:OnRemoved()
end

function modifier_maple_devour_crystal:OnDestroy()
	if not IsServer() then return end
	if self.intrinsic then
		self.intrinsic:RemoveCrystal( self )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_devour_crystal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_MANA_BONUS,
	}

	return funcs
end

function modifier_maple_devour_crystal:GetModifierExtraManaBonus( params )
	if not IsServer() then
		return self:GetStackCount()
	end

	return self.mana_bonus
end