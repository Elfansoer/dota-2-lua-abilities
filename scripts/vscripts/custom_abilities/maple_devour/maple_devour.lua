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

--[[
Notes on Toggles, Cooldowns, and Ability Charges:
- Toggle Abilities never call OnSpellStart upon cast. They call OnToggle instead
- Ability Charges don't react on OnToggle call
	- Which means, casting Toggle abilities do not consume charges
- Ability Charges only react on casting the ability that calls OnSpellStart
	- ability:UseResources() do not consume charges
	- ability:CastAbility() do consume charges, and it calls OnSpellStart
		- CastAbility() goes through silences
- Ability cooldowns and Ability Charges cooldowns are separate thing.
	- If ability has cooldown value, it will put ability on cooldown after cast regardless of charges.
	- Lua abilities MUST override ability:GetAbilityChargeRestoreTime() in order for charge to count up.
		- the AbilityChargeRestoreTime in KV does nothing.
	- Both are affected by cooldown reductions.
]]

--------------------------------------------------------------------------------
maple_devour = class({})
LinkLuaModifier( "modifier_maple_devour", "custom_abilities/maple_devour/modifier_maple_devour", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_devour_active", "custom_abilities/maple_devour/modifier_maple_devour_active", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_devour_crystal", "custom_abilities/maple_devour/modifier_maple_devour_crystal", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- must be set here, the KV one is not internally used
function maple_devour:GetAbilityChargeRestoreTime( level )
	-- -- use AbilityChargeRestoreTime kv as charge restore time
	-- return self.BaseClass.GetAbilityChargeRestoreTime( self, level )

	-- use AbilityCooldown as charge restore time
	return self.BaseClass.GetCooldown( self, level )
end

function maple_devour:GetCooldown( level )
	-- dont use cooldown on ability with charges
	if IsServer() then return 0 end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Passive Modifier
function maple_devour:GetIntrinsicModifierName()
	return "modifier_maple_devour"
end

--------------------------------------------------------------------------------
-- Ability Start
function maple_devour:OnSpellStart()
	-- actually do nothing
end

--------------------------------------------------------------------------------
-- Ability Toggle
function maple_devour:OnToggle()
	-- OnToggle does not proc charges, only OnSpellStart do
	
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local toggle = self:GetToggleState()

	if toggle then
		-- add modifier
		self.modifier = caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_maple_devour_active", -- modifier name
			{} -- kv
		)
	else
		if self.modifier and not self.modifier:IsNull() then
			self.modifier:Destroy()
		end
		self.modifier = nil
	end
end