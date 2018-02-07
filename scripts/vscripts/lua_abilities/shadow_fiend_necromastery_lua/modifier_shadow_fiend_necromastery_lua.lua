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
	-- get references
	self.soul_max = self:GetAbility():GetSpecialValueFor("soul_max")
	self.soul_max_scepter = self:GetAbility():GetSpecialValueFor("soul_max_scepter")
	self.soul_release = self:GetAbility():GetSpecialValueFor("soul_release")
	self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
	self.soul_hero_bonus = self:GetAbility():GetSpecialValueFor("soul_hero_bonus")
	self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
end

function modifier_shadow_fiend_necromastery_lua:OnRefresh( kv )
	-- get references
	self.soul_max = self:GetAbility():GetSpecialValueFor("soul_max")
	self.soul_max_scepter = self:GetAbility():GetSpecialValueFor("soul_max_scepter")
	self.soul_release = self:GetAbility():GetSpecialValueFor("soul_release")
	self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
	self.soul_hero_bonus = self:GetAbility():GetSpecialValueFor("soul_hero_bonus")
	self.soul_damage = self:GetAbility():GetSpecialValueFor("soul_damage")
end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_necromastery_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- soul release
function modifier_shadow_fiend_necromastery_lua:OnDeath( params )
	if IsServer() then
		self:DeathLogic( params )
		self:KillLogic( params )
	end
end

function modifier_shadow_fiend_necromastery_lua:GetModifierPreAttack_BonusDamage( params )
	return self:GetStackCount() * self.soul_damage
end

--------------------------------------------------------------------------------
function modifier_shadow_fiend_necromastery_lua:DeathLogic( params )
	-- filter
	local unit = params.unit if unit==nil then unit = params.target end
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

function modifier_shadow_fiend_necromastery_lua:KillLogic( params )
	-- filter
	local target = params.target if target==nil then target = params.unit end
	local attacker = params.attacker
	local pass = false
	if attacker==self:GetParent() then
		pass = true
	end

	-- logic
	if pass then
		self:AddStack(1)
		-- check if it is a hero
		if target:IsRealHero() then
			self:AddStack(11)
		end
	end
end


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
