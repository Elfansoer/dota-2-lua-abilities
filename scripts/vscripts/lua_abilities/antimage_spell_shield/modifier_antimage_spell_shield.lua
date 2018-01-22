modifier_antimage_spell_shield = class({})

function modifier_antimage_spell_shield:OnCreated( kv )
	if IsServer() then
		self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
	end
end

function modifier_antimage_spell_shield:OnRefresh( kv )
	if IsServer() then
		self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
	end
end

--------------------------------------------------------------------------------

function modifier_antimage_spell_shield:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_antimage_spell_shield:GetModifierMagicalResistanceBonus( params )
	return self.bonus
end
