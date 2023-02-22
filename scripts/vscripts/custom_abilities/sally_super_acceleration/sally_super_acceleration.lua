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
sally_super_acceleration = class({})
LinkLuaModifier( "modifier_sally_super_acceleration", "custom_abilities/sally_super_acceleration/modifier_sally_super_acceleration", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sally_super_acceleration_buff", "custom_abilities/sally_super_acceleration/modifier_sally_super_acceleration_buff", LUA_MODIFIER_MOTION_NONE )

function sally_super_acceleration:GetAbilityChargeRestoreTime( level )
	-- use AbilityCooldown kv as charge restore time
	return self.BaseClass.GetAbilityChargeRestoreTime( self, level )
end


--------------------------------------------------------------------------------
-- Ability Start
function sally_super_acceleration:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- logic
	caster:AddNewModifier(
		caster,
		self,
		"modifier_sally_super_acceleration",
		{duration = duration}
	)

	-- logic
	caster:AddNewModifier(
		caster,
		self,
		"modifier_sally_super_acceleration_buff",
		{duration = duration + 0.1}
	)
end