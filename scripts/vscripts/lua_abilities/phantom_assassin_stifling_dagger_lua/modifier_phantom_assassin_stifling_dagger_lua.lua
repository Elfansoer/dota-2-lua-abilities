modifier_phantom_assassin_stifling_dagger_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_phantom_assassin_stifling_dagger_lua:IsHidden()
	return false
end

function modifier_phantom_assassin_stifling_dagger_lua:IsDebuff()
	return true
end

function modifier_phantom_assassin_stifling_dagger_lua:IsStunDebuff()
	return false
end

function modifier_phantom_assassin_stifling_dagger_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_phantom_assassin_stifling_dagger_lua:OnCreated( kv )
	-- references
	self.move_slow = self:GetAbility():GetSpecialValueFor( "move_slow" )
end

function modifier_phantom_assassin_stifling_dagger_lua:OnRefresh( kv )
	-- references
	self.move_slow = self:GetAbility():GetSpecialValueFor( "move_slow" )	
end

function modifier_phantom_assassin_stifling_dagger_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_phantom_assassin_stifling_dagger_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_phantom_assassin_stifling_dagger_lua:GetModifierMoveSpeedBonus_Percentage()
	self.move_slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_phantom_assassin_stifling_dagger_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_phantom_assassin_stifling_dagger_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
