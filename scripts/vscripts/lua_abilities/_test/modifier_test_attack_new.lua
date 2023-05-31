modifier_test = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test:IsHidden()
	return false
end

function modifier_test:IsDebuff()
	return false
end

function modifier_test:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		-- -- server loop (also client loop)
		-- MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION,

		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK_RECORD,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,
		MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PRE_ATTACK,

		MODIFIER_EVENT_ON_ATTACK,

		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		
		MODIFIER_EVENT_ON_ATTACK_LANDED,

		MODIFIER_PROPERTY_AVOID_SPELL,

		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE,

		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL,
		MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK,

		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_PROPERTY_AVOID_DAMAGE,

		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BASE_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE,

		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,

		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,

		MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,

		MODIFIER_EVENT_ON_ATTACK_FINISHED,

		-- -- not called during normal attack/spell
		-- MODIFIER_EVENT_ON_ATTACK_ALLIED,
		-- MODIFIER_EVENT_ON_ATTACK_CANCELLED,
		-- MODIFIER_EVENT_ON_ATTACK_FAIL,
		-- MODIFIER_EVENT_ON_KILL,
		-- MODIFIER_EVENT_ON_MAGIC_DAMAGE_CALCULATED,
		
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION_AMPLIFY,
		-- MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION,
		-- MODIFIER_PROPERTY_PHYSICALDAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_DEADLY_BLOW,
		-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL_TARGET,
		-- MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL,
		-- MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_CREEP,
		
		-- MODIFIER_PROPERTY_BONUSDAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BASE_REDUCTION,
		-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_ILLUSIONS,
		-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_UNIQUE,
		-- MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
		-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_POST,
		-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC,
	}
	return funcs
end


--------------------------------------------------------------------------------

local function selectiveprint( str )
	if IsServer() then print(str) end
	-- if not IsServer() then print(str) end
end

function modifier_test:printImportant( params )
	if IsServer() then
		-- if params.attacker ~= nil then print("","attacker",params.attacker,"health",params.attacker:GetHealth()) end
		-- if params.unit ~= nil then print("","unit\t",params.unit,"health",params.unit:GetHealth()) end
		-- if params.target ~= nil then print("","target\t",params.target,"health",params.target:GetHealth()) end
		-- if params.damage ~= nil then print("","damage\t",params.damage) end
		-- if params.original_damage ~= nil then print("","original_damage",params.original_damage) end
		-- if params.damage_type ~= nil then print("","damage_type",params.damage_type) end
		-- print("","health",self:GetParent():GetHealth())
	end
end

function modifier_test:OnAttack( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK")
	self:printImportant( params )
end

function modifier_test:OnAttacked( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACKED")
	self:printImportant( params )
end

function modifier_test:OnAttackAllied( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_ALLIED")
	self:printImportant( params )
end

function modifier_test:OnAttackCancelled( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_CANCELLED")
	self:printImportant( params )
end

function modifier_test:OnAttackFail( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_FAIL")
	self:printImportant( params )
end

function modifier_test:OnAttackFinished( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_FINISHED")
	self:printImportant( params )
end

function modifier_test:OnAttackLanded( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_LANDED")
	self:printImportant( params )
end

function modifier_test:OnAttackRecord( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_RECORD")
	self:printImportant( params )
end

function modifier_test:OnAttackRecordDestroy( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY")
	self:printImportant( params )
end

function modifier_test:OnAttackStart( params )
	selectiveprint("MODIFIER_EVENT_ON_ATTACK_START")
	self:printImportant( params )
end

function modifier_test:OnDamageCalculated( params )
	selectiveprint("MODIFIER_EVENT_ON_DAMAGE_CALCULATED")
	self:printImportant( params )
end

function modifier_test:OnKill( params )
	selectiveprint("MODIFIER_EVENT_ON_KILL")
	self:printImportant( params )
end

function modifier_test:OnMagicDamageCalculated( params )
	selectiveprint("MODIFIER_EVENT_ON_MAGIC_DAMAGE_CALCULATED")
	self:printImportant( params )
end

function modifier_test:OnTakeDamage( params )
	selectiveprint("MODIFIER_EVENT_ON_TAKEDAMAGE")
	self:printImportant( params )
end

function modifier_test:OnTakeDamageKillCredit( params )
	selectiveprint("MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT")
	self:printImportant( params )
end

function modifier_test:GetAbsoluteNoDamageMagical( params )
	selectiveprint("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL")
	self:printImportant( params )
end

function modifier_test:GetAbsoluteNoDamagePhysical( params )
	selectiveprint("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL")
	self:printImportant( params )
end

function modifier_test:GetAbsoluteNoDamagePure( params )
	selectiveprint("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE")
	self:printImportant( params )
end

function modifier_test:GetModifierAvoidDamage( params )
	selectiveprint("MODIFIER_PROPERTY_AVOID_DAMAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierAvoidSpell( params )
	selectiveprint("MODIFIER_PROPERTY_AVOID_SPELL")
	self:printImportant( params )
end

function modifier_test:GetModifierBaseAttack_BonusDamage( params )
	selectiveprint("MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierBaseDamageOutgoing_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierBaseDamageOutgoing_PercentageUnique( params )
	selectiveprint("MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE")
	self:printImportant( params )
end

function modifier_test:GetModifierBonusDamageOutgoing_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_BONUSDAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierDamageOutgoing_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierDamageOutgoing_Percentage_Illusion( params )
	selectiveprint("MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION")
	self:printImportant( params )
end

function modifier_test:GetModifierDamageOutgoing_Percentage_Illusion_Amplify( params )
	selectiveprint("MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION_AMPLIFY")
	self:printImportant( params )
end

function modifier_test:GetModifierIncomingDamageConstant( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT")
	self:printImportant( params )
	if not IsServer() then
		return 300
	end

end

function modifier_test:aaaa( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION")
	self:printImportant( params )
end

function modifier_test:GetModifierIncomingDamage_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierIncomingPhysicalDamageConstant( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT")
	self:printImportant( params )
	if not IsServer() then
		return 100
	end
end

function modifier_test:GetModifierIncomingPhysicalDamage_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierIncomingSpellDamageConstant( params )
	selectiveprint("MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT")
	self:printImportant( params )
	if not IsServer() then
		return 200
	end
end

function modifier_test:GetModifierMagical_ConstantBlock( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceBaseReduction( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BASE_REDUCTION")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceBonus( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceBonusIllusions( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_ILLUSIONS")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceBonusUnique( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_UNIQUE")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceDecrepifyUnique( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE")
	self:printImportant( params )
end

function modifier_test:GetModifierMagicalResistanceDirectModification( params )
	selectiveprint("MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION")
	self:printImportant( params )
end

function modifier_test:GetModifierOverrideAttackDamage( params )
	selectiveprint("MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE")
	self:printImportant( params )
end

function modifier_test:GetOverrideAttackMagical( params )
	selectiveprint("MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalDamageOutgoing_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICALDAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorBase_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BASE_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorBonus( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorBonusPost( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_POST")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorBonusUnique( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorBonusUniqueActive( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysicalArmorTotal_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysical_ConstantBlock( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysical_ConstantBlockSpecial( params )
	selectiveprint("MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_BonusDamage( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_BonusDamagePostCrit( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_BonusDamage_Proc( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_BonusDamage_Target( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_CriticalStrike( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_DeadlyBlow( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_DEADLY_BLOW")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack_Target_CriticalStrike( params )
	selectiveprint("MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE")
	self:printImportant( params )
end

function modifier_test:GetModifierPreAttack( params )
	selectiveprint("MODIFIER_PROPERTY_PRE_ATTACK")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_BonusDamage_Magical( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_BonusDamage_Magical_Target( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL_TARGET")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_BonusDamage_Physical( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_BonusDamage_Pure( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_ConvertPhysicalToMagical( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL")
	self:printImportant( params )
end

function modifier_test:GetModifierProcAttack_Feedback( params )
	selectiveprint("MODIFIER_PROPERTY_PROCATTACK_FEEDBACK")
	self:printImportant( params )
end

function modifier_test:GetModifierSpellAmplify_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierSpellAmplify_PercentageCreep( params )
	selectiveprint("MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_CREEP")
	self:printImportant( params )
end

function modifier_test:GetModifierSpellAmplify_PercentageUnique( params )
	selectiveprint("MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE")
	self:printImportant( params )
end

function modifier_test:GetModifierTotalDamageOutgoing_Percentage( params )
	selectiveprint("MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
end

function modifier_test:GetModifierTotal_ConstantBlock( params )
	selectiveprint("MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK")
	self:printImportant( params )
end

function modifier_test:GetModifierPhysical_ConstantBlockUnavoidablePreArmor( params )
	selectiveprint("MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR")
	self:printImportant( params )
end




-- MODIFIER_EVENT_ON_ATTACK = 180 -- OnAttack
-- MODIFIER_EVENT_ON_ATTACKED = 201 -- OnAttacked
-- MODIFIER_EVENT_ON_ATTACK_ALLIED = 183 -- OnAttackAllied
-- MODIFIER_EVENT_ON_ATTACK_CANCELLED = 253 -- OnAttackCancelled
-- MODIFIER_EVENT_ON_ATTACK_FAIL = 182 -- OnAttackFail
-- MODIFIER_EVENT_ON_ATTACK_FINISHED = 242 -- OnAttackFinished
-- MODIFIER_EVENT_ON_ATTACK_LANDED = 181 -- OnAttackLanded
-- MODIFIER_EVENT_ON_ATTACK_RECORD = 178 -- OnAttackRecord
-- MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY = 250 -- OnAttackRecordDestroy
-- MODIFIER_EVENT_ON_ATTACK_START = 179 -- OnAttackStart
-- MODIFIER_EVENT_ON_DAMAGE_CALCULATED = 199 -- OnDamageCalculated
-- MODIFIER_EVENT_ON_KILL = 238 -- OnKill
-- MODIFIER_EVENT_ON_MAGIC_DAMAGE_CALCULATED = 200 -- OnMagicDamageCalculated
-- MODIFIER_EVENT_ON_TAKEDAMAGE = 194 -- OnTakeDamage
-- MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT = 212 -- OnTakeDamageKillCredit
-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL = 153 -- GetAbsoluteNoDamageMagical
-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL = 152 -- GetAbsoluteNoDamagePhysical
-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE = 154 -- GetAbsoluteNoDamagePure
-- MODIFIER_PROPERTY_AVOID_DAMAGE = 68 -- GetModifierAvoidDamage
-- MODIFIER_PROPERTY_AVOID_SPELL = 69 -- GetModifierAvoidSpell
-- MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE = 4 -- GetModifierBaseAttack_BonusDamage
-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE = 57 -- GetModifierBaseDamageOutgoing_Percentage
-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE_UNIQUE = 58 -- GetModifierBaseDamageOutgoing_PercentageUnique
-- MODIFIER_PROPERTY_BONUSDAMAGEOUTGOING_PERCENTAGE = 40 -- GetModifierBonusDamageOutgoing_Percentage
-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE = 41 -- GetModifierDamageOutgoing_Percentage
-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION = 42 -- GetModifierDamageOutgoing_Percentage_Illusion
-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE_ILLUSION_AMPLIFY = 43 -- GetModifierDamageOutgoing_Percentage_Illusion_Amplify
-- MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT = 269 -- GetModifierPropertyIncomingDamage_Constant
-- MODIFIER_PROPERTY_INCOMING_DAMAGE_ILLUSION = 247 -- aaa
-- MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE = 59 -- GetModifierIncomingDamage_Percentage
-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT = 61 -- GetModifierIncomingPhysicalDamageConstant
-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE = 60 -- GetModifierIncomingPhysicalDamage_Percentage
-- MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT = 62 -- GetModifierIncomingSpellDamageConstant
-- MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK = 134 -- GetModifierMagical_ConstantBlock
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BASE_REDUCTION = 78 -- GetModifierMagicalResistanceBaseReduction
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS = 80 -- GetModifierMagicalResistanceBonus
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_ILLUSIONS = 81 -- GetModifierMagicalResistanceBonusIllusions
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS_UNIQUE = 82 -- GetModifierMagicalResistanceBonusUnique
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE = 83 -- GetModifierMagicalResistanceDecrepifyUnique
-- MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION = 79 -- GetModifierMagicalResistanceDirectModification
-- MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE = 11 -- GetModifierOverrideAttackDamage
-- MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL = 166 -- GetOverrideAttackMagical
-- MODIFIER_PROPERTY_PHYSICALDAMAGEOUTGOING_PERCENTAGE = 266 -- GetModifierPhysicalDamageOutgoing_Percentage
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BASE_PERCENTAGE = 71 -- GetModifierPhysicalArmorBase_Percentage
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS = 73 -- GetModifierPhysicalArmorBonus
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_POST = 76 -- GetModifierPhysicalArmorBonusPost
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE = 74 -- GetModifierPhysicalArmorBonusUnique
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS_UNIQUE_ACTIVE = 75 -- GetModifierPhysicalArmorBonusUniqueActive
-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE = 72 -- GetModifierPhysicalArmorTotal_Percentage
-- MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK = 135 -- GetModifierPhysical_ConstantBlock
-- MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK_SPECIAL = 136 -- GetModifierPhysical_ConstantBlockSpecial
-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE = 0 -- GetModifierPreAttack_BonusDamage
-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT = 3 -- GetModifierPreAttack_BonusDamagePostCrit
-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC = 2 -- GetModifierPreAttack_BonusDamage_Proc
-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_TARGET = 1 -- GetModifierPreAttack_BonusDamage_Target
-- MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE = 132 -- GetModifierPreAttack_CriticalStrike
-- MODIFIER_PROPERTY_PREATTACK_DEADLY_BLOW = 175 -- GetModifierPreAttack_DeadlyBlow
-- MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE = 133 -- GetModifierPreAttack_Target_CriticalStrike
-- MODIFIER_PROPERTY_PRE_ATTACK = 12 -- GetModifierPreAttack
-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL = 7 -- GetModifierProcAttack_BonusDamage_Magical
-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL_TARGET = 9 -- GetModifierProcAttack_BonusDamage_Magical_Target
-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL = 5 -- GetModifierProcAttack_BonusDamage_Physical
-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE = 8 -- GetModifierProcAttack_BonusDamage_Pure
-- MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL = 6 -- GetModifierProcAttack_ConvertPhysicalToMagical
-- MODIFIER_PROPERTY_PROCATTACK_FEEDBACK = 10 -- GetModifierProcAttack_Feedback
-- MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE = 46 -- GetModifierSpellAmplify_Percentage
-- MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_CREEP = 45 -- GetModifierSpellAmplify_PercentageCreep
-- MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE_UNIQUE = 47 -- GetModifierSpellAmplify_PercentageUnique
-- MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE = 44 -- GetModifierTotalDamageOutgoing_Percentage
-- MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK = 138 -- GetModifierTotal_ConstantBlock
-- MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK_UNAVOIDABLE_PRE_ARMOR = 137 -- GetModifierPhysical_ConstantBlockUnavoidablePreArmor

