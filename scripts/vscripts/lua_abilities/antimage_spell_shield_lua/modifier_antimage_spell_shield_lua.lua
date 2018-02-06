modifier_antimage_spell_shield_lua = class({})

function modifier_antimage_spell_shield_lua:OnCreated( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
end

function modifier_antimage_spell_shield_lua:OnRefresh( kv )
	self.bonus = self:GetAbility():GetSpecialValueFor("bonus_resist_pct")
end

--------------------------------------------------------------------------------

function modifier_antimage_spell_shield_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_antimage_spell_shield_lua:GetModifierMagicalResistanceBonus( params )
	return self.bonus
end
