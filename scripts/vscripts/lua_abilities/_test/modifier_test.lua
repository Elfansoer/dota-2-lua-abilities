modifier_test = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test:IsHidden()
	return false
end

function modifier_test:IsDebuff()
	return false
end

-- function modifier_test:GetAttributes()
-- 	return MODIFIER_ATRRIBUTE_XX + MODIFIER_ATRRIBUTE_YY 
-- end

function modifier_test:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_test:DeclareFunctions()
	local funcs = {
		-- MODIFIER_EVENT_ON_ATTACK_START,
		-- MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,

		-- MODIFIER_EVENT_ON_ATTACK,
		-- MODIFIER_EVENT_ON_ATTACK_FINISHED,

		MODIFIER_EVENT_ON_ATTACK_LANDED,
		-- MODIFIER_EVENT_ON_ATTACK_FAIL,
		
		-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,

		-- defense starts here
		-- MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		-- MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
		-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
		-- MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		-- MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		-- MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,

		-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,

		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		
		-- unused:
		-- MODIFIER_PROPERTY_PRE_ATTACK,
		-- MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,

		-- unknown:
		-- MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC,
	}

	return funcs
end

-- Status Effects
-- function modifier_test:CheckState()
-- 	local state = {
-- 	[MODIFIER_STATE_XX] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Physical attack damage calculations before dealt
function modifier_test:GetModifierBaseAttack_BonusDamage( params )
	-- what: base damage, shown as white damage, added directly, calculated in critical
	-- print("MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE")
	return 10
end
function modifier_test:GetModifierBaseDamageOutgoing_Percentage( params )
	-- print("MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamage( params )
	-- what: bonus damage, shown as green, added directly, calculated in critical
	-- print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE")
	return 10
end
function modifier_test:GetModifierDamageOutgoing_Percentage( params )
	-- print("MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE")
	return 100
end
function modifier_test:GetModifierPreAttack_CriticalStrike( params )
	-- what: multiplier damage, not shown in hud, added directly, 100 means normal
	print("MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE")
	return 200
end
function modifier_test:GetModifierPreAttack_BonusDamagePostCrit( params )
	-- what: bonus damage, not shown in hud, added directly, does not calculated in critical
	print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT")
	return 10
end
--------------------------------------------------------------------------------
-- Additional attack damage calculations before dealt
function modifier_test:GetModifierProcAttack_BonusDamage_Physical( params )
	-- what: bonus damage, has different value 
	print("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL")
	return 100
end
function modifier_test:GetModifierProcAttack_BonusDamage_Magical( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL")
	return 100
end
function modifier_test:GetModifierProcAttack_BonusDamage_Pure( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE")
	return 100
end
--------------------------------------------------------------------------------
function modifier_test:OnAttackStart( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_START")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnAttack( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnAttackFinished( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FINISHED")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnAttackLanded( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_LANDED")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnAttackFail( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FAIL")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnAttacked( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACKED")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
function modifier_test:OnTakeDamage( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_TAKEDAMAGE")
			print("attacker",params.attacker)
			print("unit",params.unit)
			print("target",params.target)
			print("damage",params.damage)
			print("original_damage",params.original_damage)
			print("damage_type",params.damage_type)
		end
	end
end
--------------------------------------------------------------------------------
function modifier_test:GetModifierTotalDamageOutgoing_Percentage( params )
	print("MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE")
	return 100
end

--------------------------------------------------------------------------------
function modifier_test:GetModifierPhysical_ConstantBlock( params )
	-- what: blocks all physical damage (be it from pre or post attack landed)
	print("MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK")
	return 50
end
function modifier_test:GetModifierPhysicalArmorBonus( params )
	-- print("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS")
	return 20
end
function modifier_test:GetModifierIncomingSpellDamageConstant( params )
	print("MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT")
	return 200
end
function modifier_test:GetModifierIncomingDamage_Percentage( params )
	print("MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE")
	return 0
end
function modifier_test:GetModifierIncomingPhysicalDamage_Percentage( params )
	print("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE")
	return 0
end
function modifier_test:GetModifierIncomingPhysicalDamageConstant( params )
	print("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT")
	return 0
end
function modifier_test:GetModifierTotal_ConstantBlock( params )
	print("MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK")
	return 0
end
function modifier_test:GetModifierAvoidDamage( params )
	print("MODIFIER_PROPERTY_AVOID_DAMAGE")
	return true
end

--------------------------------------------------------------------------------
function modifier_test:GetModifierProcAttack_Feedback( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_FEEDBACK")
	return 100
end
--------------------------------------------------------------------------------
function modifier_test:GetModifierPreAttack_BonusDamage_Proc( params )
	print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC")
	return 100
end
function modifier_test:GetModifierPreAttack_Target_CriticalStrike( params )
	print("MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE")
	return 100
end
function modifier_test:GetModifierPreAttack( params )
	print("MODIFIER_PROPERTY_PRE_ATTACK")
	return 100
end
