modifier_azura_gaze_of_exile_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_azura_gaze_of_exile_buff:IsHidden()
	-- final: true
	return false
end

function modifier_azura_gaze_of_exile_buff:IsDebuff()
	return false
end

function modifier_azura_gaze_of_exile_buff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_azura_gaze_of_exile_buff:OnCreated( kv )
	-- references
	self.attack_range = self:GetAbility():GetSpecialValueFor("bonus_range")
	self.cast_range = self.attack_range
	if not self:GetParent():IsRangedAttacker() then
		self.attack_range = self.attack_range / 2
	end
	-- self:GetParent():NoTeamSelect()
end

function modifier_azura_gaze_of_exile_buff:OnRefresh( kv )
	-- references
	self.attack_range = self:GetAbility():GetSpecialValueFor("bonus_range")
	self.cast_range = self.attack_range
	if not self:GetParent():IsRangedAttacker() then
		self.attack_range = self.attack_range / 2
	end
	-- self:GetParent():NoTeamSelect()
end

function modifier_azura_gaze_of_exile_buff:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_azura_gaze_of_exile_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}

	return funcs
end

function modifier_azura_gaze_of_exile_buff:OnOrder( params )
	if IsServer() then
		-- filter
		local unit = params.unit
		local target = params.target
		local pass = true
		if target~=nil then
			if not target:HasModifier("modifier_azura_gaze_of_exile") then
				pass = false
			end
		end

		-- logic
		if pass then
			self:Destroy()
		end
	end
end

function modifier_azura_gaze_of_exile_buff:GetModifierCastRangeBonus( params )
	return self.cast_range
end
function modifier_azura_gaze_of_exile_buff:GetModifierAttackRangeBonus( params )
	return self.attack_range
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_azura_gaze_of_exile_buff:CheckState()
	local state = {
	[MODIFIER_STATE_CANNOT_MISS] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_azura_gaze_of_exile_buff:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_azura_gaze_of_exile_buff:GetEffectAttachType()
-- 	return PATTACH_XX
-- end