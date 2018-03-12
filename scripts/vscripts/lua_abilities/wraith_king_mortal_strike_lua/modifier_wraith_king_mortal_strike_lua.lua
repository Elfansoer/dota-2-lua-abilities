modifier_wraith_king_mortal_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wraith_king_mortal_strike_lua:IsHidden()
	return self:GetStackCount()==0
end

function modifier_wraith_king_mortal_strike_lua:IsDebuff()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wraith_king_mortal_strike_lua:OnCreated( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" ) -- special value
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "crit_mult" ) -- special value
	self.mortal_chance = self:GetAbility():GetSpecialValueFor( "mortal_chance" ) -- special value
	self.max_skeleton_charges = self:GetAbility():GetSpecialValueFor( "max_skeleton_charges" ) -- special value
end

function modifier_wraith_king_mortal_strike_lua:OnRefresh( kv )
	-- references
	self.crit_chance = self:GetAbility():GetSpecialValueFor( "crit_chance" ) -- special value
	self.crit_mult = self:GetAbility():GetSpecialValueFor( "crit_mult" ) -- special value
	self.mortal_chance = self:GetAbility():GetSpecialValueFor( "mortal_chance" ) -- special value
	self.max_skeleton_charges = self:GetAbility():GetSpecialValueFor( "max_skeleton_charges" ) -- special value
end

function modifier_wraith_king_mortal_strike_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wraith_king_mortal_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_wraith_king_mortal_strike_lua:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() then
		local pass = false
		if params.target:GetTeamNumber()~=self:GetParent():GetTeamNumber() then
			pass = true
		end

		if pass and self:RollChance(self.crit_chance) then
			self.attack_record = params.record
			-- Check condition for instakill
			if (not params.target:IsOwnedByAnyPlayer()) and params.target:IsCreep() and (not params.target:IsAncient()) then
				self.instaKill = true
				return 0
			else
				return self.crit_mult
			end
		end
	end
	return 0
end
function modifier_wraith_king_mortal_strike_lua:GetModifierProcAttack_Feedback( params )
	if IsServer() then
		-- filter
		local pass = false
		if self.attack_record and params.record==self.attack_record then
			pass = true
			self.attack_record = nil
		end

		-- logic
		if pass then
			self:PlayEffects( params.target )

			if self.instaKill then
				self.instaKill = false
				params.target:Kill( self:GetAbility(), self:GetParent() )
				self:AddStack()
			end
		end
	end
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wraith_king_mortal_strike_lua:PlayEffects( target )
	-- get resource
	-- local particle_impact = "particles/units/heroes/hero_skeletonking/skeletonking_mortalstrike.vpcf"
	local sound_impact = "Hero_SkeletonKing.CriticalStrike"

	-- play effect
	-- local effect_impact = ParticleManager:CreateParticle( particle_impact, PATTACH_ABSORIGIN_FOLLOW, target )
	-- -- todo: find correct particle control
	-- ParticleManager:SetParticleControl( effect_impact, 2, target:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( effect_impact )

	-- play sound
	EmitSoundOn( sound_impact, target )
end

--------------------------------------------------------------------------------
-- Helper function
function modifier_wraith_king_mortal_strike_lua:RollChance( chance )
	local rand = math.random()
	if rand<chance/100 then
		return true
	end
	return false
end

function modifier_wraith_king_mortal_strike_lua:AddStack()
	local target = self:GetStackCount() + 1
	if target <= self.max_skeleton_charges then
		self:IncrementStackCount()
	end
end