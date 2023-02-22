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
maple_martyrs_devotion = class({})
LinkLuaModifier( "modifier_maple_martyrs_devotion", "custom_abilities/maple_martyrs_devotion/modifier_maple_martyrs_devotion", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_maple_martyrs_devotion_buff", "custom_abilities/maple_martyrs_devotion/modifier_maple_martyrs_devotion_buff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function maple_martyrs_devotion:OnAbilityPhaseStart()
	return true -- if success
end

function maple_martyrs_devotion:OnAbilityPhaseInterrupted()
end

--------------------------------------------------------------------------------
-- Ability Start
function maple_martyrs_devotion:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local init_cost = self:GetSpecialValueFor( "init_cost" )

	-- health cost 
	local damageTable = {
		victim = caster,
		attacker = caster,
		damage = init_cost,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, --Optional.
	}
	ApplyDamage(damageTable)

	-- logic
	caster:AddNewModifier(
		caster,
		self,
		"modifier_maple_martyrs_devotion",
		{}
	)

	-- check sister ability
	local ability = caster:FindAbilityByName( "maple_martyrs_devotion_end" )
	if not ability then
		ability = caster:AddAbility( "maple_martyrs_devotion_end" )
		ability:SetStolen( true )
	end

	-- check ability level
	ability:SetLevel( 1 )

	-- switch ability layout
	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)

	-- set cooldown
	ability:StartCooldown( ability:GetCooldown( 1 ) )
end


--------------------------------------------------------------------------------
-- End ability
--------------------------------------------------------------------------------
maple_martyrs_devotion_end = class({})
function maple_martyrs_devotion_end:OnSpellStart()
	local modifier = self:GetCaster():FindModifierByName("modifier_maple_martyrs_devotion")
	if modifier then
		modifier:Destroy()
	end
end