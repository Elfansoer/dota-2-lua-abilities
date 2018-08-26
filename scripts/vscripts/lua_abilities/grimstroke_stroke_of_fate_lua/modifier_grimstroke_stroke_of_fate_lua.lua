modifier_grimstroke_stroke_of_fate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_grimstroke_stroke_of_fate_lua:IsHidden()
	return false
end

function modifier_grimstroke_stroke_of_fate_lua:IsDebuff()
	return true
end

function modifier_grimstroke_stroke_of_fate_lua:IsStunDebuff()
	return false
end

function modifier_grimstroke_stroke_of_fate_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_grimstroke_stroke_of_fate_lua:OnCreated( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_slow_pct" ) -- special value
end

function modifier_grimstroke_stroke_of_fate_lua:OnRefresh( kv )
	-- references
	self.slow = self:GetAbility():GetSpecialValueFor( "movement_slow_pct" ) -- special value	
end

function modifier_grimstroke_stroke_of_fate_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_grimstroke_stroke_of_fate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end
function modifier_grimstroke_stroke_of_fate_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_grimstroke_stroke_of_fate_lua:GetEffectName()
	return "particles/units/heroes/hero_grimstroke/grimstroke_dark_artistry_debuff.vpcf"
end

function modifier_grimstroke_stroke_of_fate_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end