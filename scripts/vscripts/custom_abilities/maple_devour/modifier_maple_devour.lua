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
-- Helpers
local function FindIndex( table, value )
	for i,v in ipairs(table) do
		if v==value then
			return i
		end
	end
end

--------------------------------------------------------------------------------
modifier_maple_devour = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_devour:IsHidden()
	return true
end

function modifier_maple_devour:IsDebuff()
	return false
end

function modifier_maple_devour:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_devour:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.str_armor = self:GetAbility():GetSpecialValueFor( "armor_per_strength" )

	if not IsServer() then return end
	self.crystals = {}

	self:StartIntervalThink(0.1)
end

function modifier_maple_devour:OnRefresh( kv )
	self.str_armor = self:GetAbility():GetSpecialValueFor( "armor_per_strength" )
end

function modifier_maple_devour:OnRemoved()
end

function modifier_maple_devour:OnDestroy()
end

function modifier_maple_devour:AddCrystal( modifier )
	table.insert( self.crystals, modifier )
end

function modifier_maple_devour:RemoveCrystal( modifier )
	table.remove( self.crystals, FindIndex(self.crystals, modifier) )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_devour:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_maple_devour:GetModifierPhysicalArmorBonus( params )
	if self.parent:PassivesDisabled() then return 0 end
	return self.parent:GetStrength() * self.str_armor
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_maple_devour:OnIntervalThink()
	if #self.crystals < 1 then return end
	
	local deficit = self.parent:GetMaxMana() - self.parent:GetMana()
	local crystal_to_destroy = {}

	-- check if any crystal is empty
	local mana_count = 0
	for i,crystal in ipairs(self.crystals) do
		mana_count = mana_count + crystal:GetStackCount()
		
		if mana_count < deficit then
			crystal_to_destroy[crystal] = true
		else
			break
		end
	end

	for crystal,_ in pairs(crystal_to_destroy) do
		crystal:Destroy()
	end
end
