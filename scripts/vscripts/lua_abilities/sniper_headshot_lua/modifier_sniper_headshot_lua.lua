modifier_sniper_headshot_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sniper_headshot_lua:IsHidden()
	return true
end

function modifier_sniper_headshot_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sniper_headshot_lua:OnCreated( kv )
	-- references
	self.proc_chance = self:GetAbility():GetSpecialValueFor( "proc_chance" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" ) -- special value
	if IsServer() then
		self.damage = self:GetAbility():GetAbilityDamage()
	end
end

function modifier_sniper_headshot_lua:OnRefresh( kv )
	-- references
	self.proc_chance = self:GetAbility():GetSpecialValueFor( "proc_chance" ) -- special value
	self.slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" ) -- special value
	self.slow = self:GetAbility():GetSpecialValueFor( "slow" ) -- special value
	if IsServer() then
		self.damage = self:GetAbility():GetAbilityDamage()
	end
end

function modifier_sniper_headshot_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sniper_headshot_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end

function modifier_sniper_headshot_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- roll dice
		if RandomInt(1,100)<=self.proc_chance then
			params.target:AddNewModifier(
				self:GetParent(), -- player source
				self, -- ability source
				"modifier_sniper_headshot_lua_slow", -- modifier name
				{ 
					duration = self.slow_duration,
					slow = self.slow, 
				} -- kv
			)
			return self.damage
		end
	end
end