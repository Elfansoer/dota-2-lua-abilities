modifier_troll_warlord_berserkers_rage_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_troll_warlord_berserkers_rage_lua:IsHidden()
	return false
end

function modifier_troll_warlord_berserkers_rage_lua:IsDebuff()
	return false
end

function modifier_troll_warlord_berserkers_rage_lua:IsPurgable()
	return false
end

function modifier_troll_warlord_berserkers_rage_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_troll_warlord_berserkers_rage_lua:OnCreated( kv )
	-- references
	self.bat_override = self:GetAbility():GetSpecialValueFor( "base_attack_time" ) -- special value
	self.bonus_hp = self:GetAbility():GetSpecialValueFor( "bonus_hp" ) -- special value
	self.bonus_move_speed = self:GetAbility():GetSpecialValueFor( "bonus_move_speed" ) -- special value
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" ) -- special value
	self.melee_range = 150

	self.bash_chance = self:GetAbility():GetSpecialValueFor( "bash_chance" ) -- special value
	self.bash_damage = self:GetAbility():GetSpecialValueFor( "bash_damage" ) -- special value
	self.bash_duration = self:GetAbility():GetSpecialValueFor( "bash_duration" ) -- special value

	-- Save previous states
	self.pre_attack_capability = self:GetParent():GetAttackCapability()
	self.delta_attack_range = self.melee_range - self:GetParent():GetAttackRange()
	self.delta_bat = self.bat_override - self:GetBaseAttackTime()

	-- set attack compatibility
	self:GetParent():SetAttackCapability( DOTA_UNIT_CAP_MELEE_ATTACK )
end

function modifier_troll_warlord_berserkers_rage_lua:OnRefresh( kv )
	-- references
	self.bat_override = self:GetAbility():GetSpecialValueFor( "base_attack_time" ) -- special value
	self.bonus_hp = self:GetAbility():GetSpecialValueFor( "bonus_hp" ) -- special value
	self.bonus_move_speed = self:GetAbility():GetSpecialValueFor( "bonus_move_speed" ) -- special value
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" ) -- special value

	self.bash_chance = self:GetAbility():GetSpecialValueFor( "bash_chance" ) -- special value
	self.bash_damage = self:GetAbility():GetSpecialValueFor( "bash_damage" ) -- special value
	self.bash_duration = self:GetAbility():GetSpecialValueFor( "bash_duration" ) -- special value
end

function modifier_troll_warlord_berserkers_rage_lua:OnDestroy( kv )
	self:GetParent():SetAttackCapability( self.pre_attack_capability )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_troll_warlord_berserkers_rage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,

		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,

		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_MAGICAL,
	}

	return funcs
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierBaseAttackTimeConstant()
	return -self.delta_bat
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierAttackRangeBonus()
	return self.delta_attack_range
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierHealthBonus()
	return self.bonus_hp
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_move_speed
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_troll_warlord_berserkers_rage_lua:GetModifierProcAttack_BonusDamage_Magical( params )
	if IsServer() then
		-- roll chance
		if self:RollChance( self.bash_chance ) then
			params.target:AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_generic_stunned_lua",
				{ duration = self.bash_duration}
			)
			return self.bash_damage
		end
		return 0
	end
end

--------------------------------------------------------------------------------
-- Helper functions
function modifier_troll_warlord_berserkers_rage_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_troll_warlord_berserkers_rage_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_troll_warlord_berserkers_rage_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end