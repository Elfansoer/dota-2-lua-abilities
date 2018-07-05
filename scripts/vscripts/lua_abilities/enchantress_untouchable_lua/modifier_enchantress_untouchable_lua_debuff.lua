modifier_enchantress_untouchable_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enchantress_untouchable_lua_debuff:IsHidden()
	return false
end

function modifier_enchantress_untouchable_lua_debuff:IsDebuff()
	return true
end

function modifier_enchantress_untouchable_lua_debuff:IsStunDebuff()
	return false
end

function modifier_enchantress_untouchable_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enchantress_untouchable_lua_debuff:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" ) -- special value
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
end

function modifier_enchantress_untouchable_lua_debuff:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed" ) -- special value
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
end

function modifier_enchantress_untouchable_lua_debuff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_enchantress_untouchable_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PRE_ATTACK,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,

		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_enchantress_untouchable_lua_debuff:GetModifierPreAttack( params )
	if IsServer() then
		-- record the attack that causes slow
		if not self.HasAttacked then
			self.record = params.record
		end

		-- check if start attacking another
		if params.target~=self:GetCaster() then
			self.attackOther = true
		end
	end
end

function modifier_enchantress_untouchable_lua_debuff:OnAttack( params )
	if IsServer() then
		if params.record~=self.record then return end

		-- let the debuff persists
		self:SetDuration(self.duration, true)
		self.HasAttacked = true
	end
end

function modifier_enchantress_untouchable_lua_debuff:OnAttackFinished( params )
	if IsServer() then
		if params.attacker~=self:GetParent() then return end
		
		-- destroy if cancel before attacks
		if not self.HasAttacked then
			self:Destroy()
		end

		-- destroy if finished attacking other units
		if self.attackOther then
			self:Destroy()
		end
	end
end

function modifier_enchantress_untouchable_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	if IsServer() then
		if self:GetParent():GetAggroTarget()==self:GetCaster() then
			return self.slow
		else
			return 0
		end
	end

	return self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_enchantress_untouchable_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_enchantress/enchantress_untouchable.vpcf"
end

function modifier_enchantress_untouchable_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end