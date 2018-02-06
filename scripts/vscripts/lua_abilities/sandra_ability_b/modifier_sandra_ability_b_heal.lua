modifier_sandra_ability_b_heal = class({})

function modifier_sandra_ability_b_heal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_ability_b_heal:OnCreated( kv )
	self.regen = self:GetAbility():GetSpecialValueFor( "bonus_regen" )
	-- some effect goes here
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_ability_b_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_sandra_ability_b_heal:GetModifierConstantHealthRegen( params )
	return self.regen
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_sandra_ability_b_heal:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_sandra_ability_b_heal:GetEffectAttachType()
-- 	return PATTACH_XX
-- end