modifier_slardar_bash_of_the_deep_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slardar_bash_of_the_deep_lua:IsHidden()
	-- actual true
	return false
end

function modifier_slardar_bash_of_the_deep_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slardar_bash_of_the_deep_lua:OnCreated( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.duration_creep = self:GetAbility():GetSpecialValueFor( "duration_creep" )
end

function modifier_slardar_bash_of_the_deep_lua:OnRefresh( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.duration_creep = self:GetAbility():GetSpecialValueFor( "duration_creep" )
end

function modifier_slardar_bash_of_the_deep_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slardar_bash_of_the_deep_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}

	return funcs
end
function modifier_slardar_bash_of_the_deep_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if self.proc then
			self.proc = false
			
			-- set duration
			local act_duration = self.duration_creep
			if params.target:IsHero() then
				act_duration = self.duration
			end

			params.target:AddNewModifier(
				self:GetParent(),
				self:GetAbility(),
				"modifier_generic_bashed_lua",
				{ duration = act_duration }
			)
		end
	end
end
function modifier_slardar_bash_of_the_deep_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		self.proc = self:RollChance( self.chance )
		local dmg = 0
		if self.proc then
			dmg = self.damage
		end
		return dmg
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_slardar_bash_of_the_deep_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_slardar_bash_of_the_deep_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

--------------------------------------------------------------------------------
-- Helper
function modifier_slardar_bash_of_the_deep_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end
