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
modifier_hwei_common = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hwei_common:IsHidden()
	return false
end

function modifier_hwei_common:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_hwei_common:RemoveOnDeath()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_common:OnCreated( kv )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not IsServer() then return end
end

function modifier_hwei_common:Init( original, swapped )
	self.original = original
	self.swapped = swapped

	self.swapped_map = {}
	for k,v in pairs(self.swapped) do
		self.swapped_map[v] = true
	end

	self:Swap( false )
end

function modifier_hwei_common:OnDestroy()
	if not IsServer() then return end
	self:Swap( true )
end

function modifier_hwei_common:Swap( isOriginalActive )

	-- use local function as replacement to `continue` keyword
	local function SwapIndex( index )
		local original_name = self.original[index]
		local swapped_name = self.swapped[index]

		-- check if original available
		local original_handle = self.caster:FindAbilityByName( original_name )
		if not original_handle then return end

		-- check if swapped available
		local swapped_handle = self.caster:FindAbilityByName( swapped_name )
		if not swapped_handle then
			swapped_handle = self.caster:AddAbility( swapped_name )
			swapped_handle:SetStolen( true )		
		end

		-- set swapped level
		swapped_handle:SetLevel( self.ability:GetLevel() )

		-- switch ability layout
		self.caster:SwapAbilities(
			original_name,
			swapped_name,
			isOriginalActive,
			not isOriginalActive
		)

		-- set inactive
		original_handle:SetActivated( isOriginalActive )
		swapped_handle:SetActivated( not isOriginalActive )
	end

	for index,_ in pairs(self.original) do
		SwapIndex( index )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hwei_common:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}

	return funcs
end

function modifier_hwei_common:OnAbilityFullyCast( params )
	if self.swapped_map[params.ability:GetAbilityName()] then
		-- set cooldown
		self.ability:StartCooldown( params.ability:GetCooldownTime() )

		-- destroy after cast
		self:Destroy()
	end
end