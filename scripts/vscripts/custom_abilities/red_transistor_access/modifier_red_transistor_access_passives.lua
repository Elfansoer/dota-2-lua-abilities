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
modifier_red_transistor_base_passive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_base_passive:IsHidden()
	return true
end

function modifier_red_transistor_base_passive:IsDebuff()
	return false
end

function modifier_red_transistor_base_passive:IsPurgable()
	return false
end

-- Optional Classifications
function modifier_red_transistor_base_passive:RemoveOnDeath()
	return false
end

function modifier_red_transistor_base_passive:DestroyOnExpire()
	return false
end

function modifier_red_transistor_base_passive:AllowIllusionDuplicate()
	return true
end

function modifier_red_transistor_base_passive:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Bounce
--------------------------------------------------------------------------------
modifier_red_transistor_bounce_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_bounce_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_bounce", "passive_reflect" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_bounce_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_red_transistor_bounce_passive:OnTakeDamage( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end
	if self:GetParent():PassivesDisabled() then return end

	local damage = params.damage * self.value/100
	local damageTable = {
		victim = params.attacker,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = params.damage_type,
		ability = self:GetAbility(), --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION, --Optional.
	}
	ApplyDamage(damageTable)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Breach
--------------------------------------------------------------------------------
modifier_red_transistor_breach_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_breach_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_breach", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_breach_passive:DeclareFunctions()
	local funcs = {
		-- MODIFIER_PROPERTY_MANA_BONUS,
		-- MODIFIER_PROPERTY_EXTRA_MANA_BONUS = 88 -- GetModifierExtraManaBonus
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_breach_passive:GetModifierExtraManaPercentage()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Crash
--------------------------------------------------------------------------------
modifier_red_transistor_crash_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_crash_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_crash", "passive_reduction" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_crash_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_crash_passive:GetModifierIncomingDamage_Percentage()
	if self:GetParent():PassivesDisabled() then return end
	return -self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Flood
--------------------------------------------------------------------------------
modifier_red_transistor_flood_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_flood_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_flood", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_flood_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		-- MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE = 82 -- GetModifierHealthRegenPercentage
	}

	return funcs
end

function modifier_red_transistor_flood_passive:GetModifierConstantHealthRegen()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Get
--------------------------------------------------------------------------------
modifier_red_transistor_get_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_get_passive:OnCreated( kv )
	-- references
	self.duration = self:GetAbility():GetAbilitySpecialValue( "red_transistor_get", "passive_duration" )
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_get", "passive_slow" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_get_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_red_transistor_get_passive:GetModifierProcAttack_Feedback( params )
	if self:GetParent():PassivesDisabled() then return end

	-- unit filter
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetParent():GetTeamNumber()
	)
	if filter~=UF_SUCCESS then return end

	-- slow target
	params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_slowed_lua", -- modifier name
		{
			duration = self.duration,
			ms_slow = self.value
		} -- kv
	)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Ping
--------------------------------------------------------------------------------
modifier_red_transistor_ping_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_ping_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_ping", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_ping_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_red_transistor_ping_passive:GetModifierAttackSpeedBonus_Constant()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Purge
--------------------------------------------------------------------------------
modifier_red_transistor_purge_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_purge_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_purge", "passive_armor" )
	self.duration = self:GetAbility():GetAbilitySpecialValue( "red_transistor_purge", "passive_duration" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_purge_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_red_transistor_purge_passive:GetModifierProcAttack_Feedback( params )
	if self:GetParent():PassivesDisabled() then return end

	-- unit filter
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetParent():GetTeamNumber()
	)
	if filter~=UF_SUCCESS then return end

	-- slow target
	params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_red_transistor_purge_passive_armor", -- modifier name
		{
			duration = self.duration,
			armor = self.value,
		} -- kv
	)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Switch
--------------------------------------------------------------------------------
modifier_red_transistor_switch_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_switch_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_switch", "passive_bonus" )
	self.value = 40

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_switch_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		-- MODIFIER_PROPERTY_STATS_AGILITY_BONUS_PERCENTAGE = 95 -- GetModifierBonusStats_Agility_Percentage
		-- MODIFIER_PROPERTY_STATS_INTELLECT_BONUS_PERCENTAGE = 96 -- GetModifierBonusStats_Intellect_Percentage
		-- MODIFIER_PROPERTY_STATS_STRENGTH_BONUS_PERCENTAGE = 94 -- GetModifierBonusStats_Strength_Percentage
	}

	return funcs
end

function modifier_red_transistor_switch_passive:GetModifierBonusStats_Strength()
	if self:GetParent():PassivesDisabled() then return end
	if self.lock1 then return 0 end

	self.lock1 = true
	local value = self:GetParent():GetStrength()
	self.lock1 = nil

	return value * self.value/100
end

function modifier_red_transistor_switch_passive:GetModifierBonusStats_Agility()
	if self:GetParent():PassivesDisabled() then return end
	if self.lock2 then return 0 end

	self.lock2 = true
	local value = self:GetParent():GetAgility()
	self.lock2 = nil

	return value * self.value/100
end

function modifier_red_transistor_switch_passive:GetModifierBonusStats_Intellect()
	if self:GetParent():PassivesDisabled() then return end
	if self.lock3 then return 0 end

	self.lock3 = true
	local value = self:GetParent():GetIntellect()
	self.lock3 = nil

	return value * self.value/100
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Cull
--------------------------------------------------------------------------------
modifier_red_transistor_cull_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_cull_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_cull", "passive_duration" )
	self.chance = self:GetAbility():GetAbilitySpecialValue( "red_transistor_cull", "passive_chance" )
	self.pseudoseed = RandomInt( 1, 100 )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_cull_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_red_transistor_cull_passive:GetModifierProcAttack_Feedback( params )
	if self:GetParent():PassivesDisabled() then return end

	-- unit filter
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetParent():GetTeamNumber()
	)
	if filter~=UF_SUCCESS then return end

	-- roll pseudo random
	if not RollPseudoRandomPercentage( self.chance, self.pseudoseed, self:GetParent() ) then return end

	-- slow target
	params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{
			duration = self.value,
			bash = 1,
		} -- kv
	)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Help
--------------------------------------------------------------------------------
modifier_red_transistor_help_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_help_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_help", "passive_crit" )
	self.chance = self:GetAbility():GetAbilitySpecialValue( "red_transistor_help", "passive_chance" )
	self.pseudoseed = RandomInt( 1, 100 )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_help_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}

	return funcs
end

function modifier_red_transistor_help_passive:GetModifierPreAttack_CriticalStrike()
	if self:GetParent():PassivesDisabled() then return end

	-- roll pseudo random
	if not RollPseudoRandomPercentage( self.chance, self.pseudoseed, self:GetParent() ) then return end

	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Jaunt
--------------------------------------------------------------------------------
modifier_red_transistor_jaunt_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_jaunt_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_jaunt", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_jaunt_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_red_transistor_jaunt_passive:GetModifierMoveSpeedBonus_Percentage()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Load
--------------------------------------------------------------------------------
modifier_red_transistor_load_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_load_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_load", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_load_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE = 52 -- GetModifierBaseDamageOutgoing_Percentage
	}

	return funcs
end

function modifier_red_transistor_load_passive:GetModifierDamageOutgoing_Percentage()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Mask
--------------------------------------------------------------------------------
modifier_red_transistor_mask_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_mask_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_mask", "passive_evasion" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_mask_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}

	return funcs
end

function modifier_red_transistor_mask_passive:GetModifierEvasion_Constant()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Spark
--------------------------------------------------------------------------------
modifier_red_transistor_spark_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_spark_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_spark", "passive_cleave" )
	self.radius = self:GetAbility():GetAbilitySpecialValue( "red_transistor_spark", "passive_radius" )
	self.radius_start = 150
	self.radius_end = 360

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_spark_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_red_transistor_spark_passive:GetModifierProcAttack_Feedback( params )
	if self:GetParent():PassivesDisabled() then return end

	-- unit filter
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetParent():GetTeamNumber()
	)
	if filter~=UF_SUCCESS then return end
	-- cleave
	DoCleaveAttack(
		params.attacker,
		params.target,
		self:GetAbility(),
		self.value,
		self.radius_start,
		self.radius_end,
		self.radius,
		"particles/units/heroes/hero_magnataur/magnataur_empower_cleave_effect.vpcf"
	)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Tap
--------------------------------------------------------------------------------
modifier_red_transistor_tap_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_tap_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_tap", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_tap_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		-- MODIFIER_PROPERTY_HEALTH_BONUS,
		-- MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS = 87 -- GetModifierExtraHealthBonus
	}

	return funcs
end

function modifier_red_transistor_tap_passive:GetModifierExtraHealthPercentage()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Void
--------------------------------------------------------------------------------
modifier_red_transistor_void_passive = class(modifier_red_transistor_base_passive)

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_void_passive:OnCreated( kv )
	-- references
	self.value = self:GetAbility():GetAbilitySpecialValue( "red_transistor_void", "passive_bonus" )

	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_void_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		-- MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE = 80 -- GetModifierTotalPercentageManaRegen
	}

	return funcs
end

function modifier_red_transistor_void_passive:GetModifierConstantManaRegen()
	if self:GetParent():PassivesDisabled() then return end
	return self.value
end
