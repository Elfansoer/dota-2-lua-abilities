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
		-- MODIFIER_EVENT_ON_ATTACK_START,

		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		-- MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		-- MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		-- MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_POST_CRIT,

		-- MODIFIER_EVENT_ON_ATTACK,
		-- MODIFIER_EVENT_ON_ATTACK_FINISHED,

		-- MODIFIER_EVENT_ON_ATTACK_LANDED,
		-- MODIFIER_EVENT_ON_ATTACK_FAIL,
		
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
		-- MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,

		-- MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		-- MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
		-- MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,

		-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		-- MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		-- MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,

		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		
		-- unused:
		-- MODIFIER_PROPERTY_PRE_ATTACK,
		-- MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,

		-- unknown/not-working:
		-- MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK,
		-- MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
		-- MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,
		-- MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC,
	}

	return funcs
end


--------------------------------------------------------------------------------
-- Physical attack damage calculations before dealt
function modifier_test:GetModifierBaseAttack_BonusDamage( params )
	-- what: base damage, shown as white damage, added directly, calculated in critical
	-- print("MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE")
	return -100
end
function modifier_test:GetModifierBaseDamageOutgoing_Percentage( params )
	-- print("MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamage( params )
	-- what: bonus damage, shown as green, added directly, calculated in critical
	-- print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE")
	return 0-10
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
	return 100
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
	return 156.25
end
function modifier_test:GetModifierProcAttack_BonusDamage_Pure( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE")
	return 100
end
--------------------------------------------------------------------------------
-- Standard damage manipulation before dealt
function modifier_test:GetModifierPhysical_ConstantBlock( params )
	-- what: blocks all physical damage (be it from pre or post attack landed)
	if IsServer() then
		print("MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK")
		self:printImportant( params )
	end
	return 50
end
function modifier_test:GetModifierPhysicalArmorBonus( params )
	-- print("MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS")
	-- self:printImportant( params )
	return 20
end
function modifier_test:GetModifierIncomingSpellDamageConstant( params )
	print("MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT")
	self:printImportant( params )
	return 10
end
function modifier_test:GetModifierIncomingPhysicalDamage_Percentage( params )
	print("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE")
	self:printImportant( params )
	return 50
end

--------------------------------------------------------------------------------
-- Special damage manipulation before dealt
function modifier_test:GetAbsoluteNoDamagePhysical( params )
	print("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL")
	self:printImportant( params )
	return 1
end
function modifier_test:GetAbsoluteNoDamageMagical( params )
	print("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL")
	self:printImportant( params )
	return 1
end
function modifier_test:GetAbsoluteNoDamagePure( params )
	print("MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE")
	self:printImportant( params )
	return 1
end

function modifier_test:GetModifierIncomingDamage_Percentage( params )
	print("MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE")
	self:printImportant( params )
	return 100
end
function modifier_test:GetModifierTotalDamageOutgoing_Percentage( params )
	print("MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE")
	self:printImportant( params )
	return 100
end

function modifier_test:GetModifierAvoidDamage( params )
	print("MODIFIER_PROPERTY_AVOID_DAMAGE")
	self:printImportant( params )
	return 0
end
function modifier_test:GetModifierTotal_ConstantBlock( params )
	print("MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK")
	self:printImportant( params )
	return 0
end
--------------------------------------------------------------------------------
-- Right before taking damage
function modifier_test:GetMinHealth( params )
	-- what: has no params
	print("MODIFIER_PROPERTY_MIN_HEALTH")
	self:printImportant( params )
	return 1
end
--------------------------------------------------------------------------------
-- Event functions (follows order, but not necessarily happens directly after another)
function modifier_test:OnAttackStart( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_START")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnAttack( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnAttackFinished( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FINISHED")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnAttackLanded( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_LANDED")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnAttackFail( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACK_FAIL")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnAttacked( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_ATTACKED")
			self:printImportant( params )
		end
	end
end
function modifier_test:OnTakeDamage( params )
	if IsServer() then
		if params.attacker==self:GetParent() then
			print("MODIFIER_EVENT_ON_TAKEDAMAGE")
			self:printImportant( params )
			params.damage = 0
		end
	end
end
--------------------------------------------------------------------------------
-- Unused
function modifier_test:GetModifierPreAttack( params )
	print("MODIFIER_PROPERTY_PRE_ATTACK")
	return 100
end
function modifier_test:GetModifierProcAttack_Feedback( params )
	-- when: projectile reached target
	print("MODIFIER_PROPERTY_PROCATTACK_FEEDBACK")
	return 100
end

--------------------------------------------------------------------------------
-- Unknown/not-working
function modifier_test:GetModifierMagical_ConstantBlock( params )
	-- not working
	print("MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK")
	self:printImportant( params )
	return 1000
end
function modifier_test:GetModifierIncomingPhysicalDamageConstant( params )
	print("MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT")
	return 100
end
function modifier_test:GetModifierPreAttack_BonusDamage_Proc( params )
	print("MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE_PROC")
	return 100
end
function modifier_test:GetModifierPreAttack_Target_CriticalStrike( params )
	print("MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE")
	return 100
end

--------------------------------------------------------------------------------



function modifier_test:printImportant( params )
	if IsServer() then
	if params.attacker ~= nil then print("","attacker",params.attacker,"health",params.attacker:GetHealth()) end
	if params.unit ~= nil then print("","unit\t",params.unit,"health",params.unit:GetHealth()) end
	if params.target ~= nil then print("","target\t",params.target,"health",params.target:GetHealth()) end
	if params.damage ~= nil then print("","damage\t",params.damage) end
	if params.original_damage ~= nil then print("","original_damage",params.original_damage) end
	if params.damage_type ~= nil then print("","damage_type",params.damage_type) end
		print("","health",self:GetParent():GetHealth())
	end
end
