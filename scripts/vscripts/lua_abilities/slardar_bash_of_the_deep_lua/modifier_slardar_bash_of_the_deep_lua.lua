modifier_slardar_bash_of_the_deep_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slardar_bash_of_the_deep_lua:IsHidden()
	return true
end

function modifier_slardar_bash_of_the_deep_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slardar_bash_of_the_deep_lua:OnCreated( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.duration_creep = self:GetAbility():GetSpecialValueFor( "duration_creep" )
end

function modifier_slardar_bash_of_the_deep_lua:OnRefresh( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
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

function modifier_slardar_bash_of_the_deep_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if IsServer() then
		-- fail if target is invalid
		if params.target:IsBuilding() or params.target:IsOther() then
			return 0
		end

		-- fail if status is invalid
		if self:GetParent():IsIllusion() or self:GetParent():PassivesDisabled() then
			return 0
		end

		if self:RollChance( self.chance ) then
			self.record = params.record
			return self.damage
		end
	end
end
function modifier_slardar_bash_of_the_deep_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		if params.record==self.record then
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

			-- Effects
			EmitSoundOn( "Hero_Slardar.Bash", params.target )
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations

--------------------------------------------------------------------------------
-- Helper
function modifier_slardar_bash_of_the_deep_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end
