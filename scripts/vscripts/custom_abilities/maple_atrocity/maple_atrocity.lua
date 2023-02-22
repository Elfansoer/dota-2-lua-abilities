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
maple_atrocity = class({})
LinkLuaModifier( "modifier_maple_atrocity", "custom_abilities/maple_atrocity/modifier_maple_atrocity", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_atrocity_unit", "custom_abilities/maple_atrocity/modifier_maple_atrocity_unit", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function maple_atrocity:OnAbilityPhaseInterrupted()
end

function maple_atrocity:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function maple_atrocity:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create unit
	local unit = CreateUnitByNameAsync(
		"npc_dota_maple_atrocity",
		caster:GetOrigin(),
		false,
		caster,
		caster,
		caster:GetTeamNumber(),
		function ( unit )
			unit:SetControllableByPlayer( caster:GetPlayerID(), false )
			unit:SetOwner( caster )

			caster:AddNewModifier(
				caster,
				self,
				"modifier_maple_atrocity",
				{}
			):Init( unit )

			unit:AddNewModifier(
				caster,
				self,
				"modifier_maple_atrocity_unit",
				{duration = duration}
			)

			-- add end ability to unit
			local ability = unit:AddAbility("maple_atrocity_end")
			if ability then
				ability:SetLevel( 1 )
			end
		end
	)
end

--------------------------------------------------------------------------------
-- End ability
--------------------------------------------------------------------------------
maple_atrocity_end = class({})
function maple_atrocity_end:OnSpellStart()
	local modifier = self:GetCaster():FindModifierByName("modifier_maple_atrocity_unit")
	if modifier then
		modifier:Destroy()
	end
end