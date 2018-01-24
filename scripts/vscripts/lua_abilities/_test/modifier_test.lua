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
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,

		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,

		MODIFIER_EVENT_ON_TAKEDAMAGE,
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
-- Declared Functions
function modifier_test:GetModifierPreAttack( params )
	-- when: at the start of attack, after MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT
	print("MODIFIER_PROPERTY_PRE_ATTACK")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamage( params )
	-- when: loop
	-- what: flat bonus damage as shown in the hud
	-- print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamage_Proc( params )
	print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamagePostCrit( params )
	-- when: at the start of attack, before MODIFIER_PROPERTY_PRE_ATTACK
	print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT")
	return 100
end
function modifier_test:GetModifierPreAttack_CriticalStrike( params )
	print("MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE")
	return 100
end
function modifier_test:GetModifierPreAttack_Target_CriticalStrike( params )
	print("MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE")
	return 100
end
--------------------------------------------------------------------------------
function modifier_test:GetModifierBaseAttack_BonusDamage( params )
	-- when: loop
	-- what: base attack bonus damage
	-- print("MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE")
	return 100
end
--------------------------------------------------------------------------------
function modifier_test:GetModifierProcAttack_BonusDamage_Physical( params )
	-- when: projectile reached target
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
function modifier_test:GetModifierProcAttack_Feedback( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_FEEDBACK")
	return 100
end
--------------------------------------------------------------------------------
function modifier_test:OnAttackStart( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_START")
		end
	end
end
function modifier_test:OnAttack( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK")
		end
	end
end
function modifier_test:OnAttackFinished( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FINISHED")
		end
	end
end
function modifier_test:OnAttackLanded( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_LANDED")
		end
	end
end
function modifier_test:OnAttackFail( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FAIL")
		end
	end
end
--------------------------------------------------------------------------------
function modifier_test:GetModifierDamageOutgoing_Percentage( params )
	-- when: loop
	-- print("MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE")
	return 0
end
function modifier_test:GetModifierTotalDamageOutgoing_Percentage( params )
	print("MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE")
	return 100
end
function modifier_test:GetModifierBaseDamageOutgoing_Percentage( params )
	-- when: loop
	-- print("MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE")
	return 0
end
--------------------------------------------------------------------------------

function modifier_test:OnTakeDamage( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_TAKEDAMAGE")
		end
	end
end
