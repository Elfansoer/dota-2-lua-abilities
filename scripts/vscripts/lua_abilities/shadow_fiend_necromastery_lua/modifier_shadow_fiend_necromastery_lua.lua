modifier_shadow_fiend_necromastery_lua = class({})

--------------------------------------------------------------------------------

function modifier_shadow_fiend_necromastery_lua:IsHidden()
	return false
end

function modifier_shadow_fiend_necromastery_lua:IsDebuff()
	return false
end

function modifier_shadow_fiend_necromastery_lua:IsPurgable()
	return false
end

function modifier_shadow_fiend_necromastery_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_necromastery_lua:OnCreated( kv )
	self:SetStackCount(0)
	if IsServer() then
		-- get references
		self.soul_max = self:GetAbility():GetSpecialValueFor("soul_max")
		self.soul_max_scepter = self:GetAbility():GetSpecialValueFor("soul_max_scepter")
		self.soul_release = self:GetAbility():GetSpecialValueFor("soul_release")
		self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
		self.soul_hero_bonus = self:GetAbility():GetSpecialValueFor("soul_hero_bonus")
		self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
	end
end

function modifier_shadow_fiend_necromastery_lua:OnRefresh( kv )
	if IsServer() then
		-- get references
		self.soul_max = self:GetAbility():GetSpecialValueFor("soul_max")
		self.soul_max_scepter = self:GetAbility():GetSpecialValueFor("soul_max_scepter")
		self.soul_release = self:GetAbility():GetSpecialValueFor("soul_release")
		self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
		self.soul_hero_bonus = self:GetAbility():GetSpecialValueFor("soul_hero_bonus")
		self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
	end
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_necromastery_lua:DeclareFunctions()
	local funcs = {
		-- todo: pick one
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_EVENT_ON_TAKEDAMAGE_KILLCREDIT,

		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- soul release
function modifier_shadow_fiend_necromastery_lua:OnDeath( params )
	if IsServer() then
		-- filter
		-- todo: find identifier
		local unit
		local pass = false
		if unit==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			local after_death = self:GetStackCount() * self.soul_release
			self:SetStackCount(math.ceil(after_death))
		end
	end
end

-- soul gain
function modifier_shadow_fiend_necromastery_lua:OnTakeDamageKillCredit( params )
	if IsServer() then
		-- filter
		-- todo: find identifier
		local target
		local attacker
		local pass = false
		if attacker==self:GetParent() then
			pass = true
		end

		-- logic
		if pass then
			AddStack(1)
			-- check if it is a hero
			if target:IsRealHero() then
				AddStack(11)
			end
		end
	end
end

function modifier_shadow_fiend_necromastery_lua:GetModifierPreAttack_BonusDamage( params )
	if IsServer() then
		return self:GetStackCount() * self.soul_damage
	end
end

--------------------------------------------------------------------------------
function modifier_shadow_fiend_necromastery_lua:AddStack( value )
	local current = self:GetStackCount()
	local after = current + value
	if self:GetParent():HasScepter() then
		if after > self.soul_max then
			after = self.soul_max
		end
	else
		if after > self.soul_max_scepter then
			after = self.soul_max_scepter
		end
	end
	self:SetStackCount( after )
end
