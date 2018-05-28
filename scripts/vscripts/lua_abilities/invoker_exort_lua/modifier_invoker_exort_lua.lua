modifier_invoker_exort_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_exort_lua:IsHidden()
	return false
end

function modifier_invoker_exort_lua:IsDebuff()
	return false
end

function modifier_invoker_exort_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_invoker_exort_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_exort_lua:OnCreated( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_per_instance" ) -- special value
end

function modifier_invoker_exort_lua:OnRefresh( kv )
	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage_per_instance" ) -- special value	
end

function modifier_invoker_exort_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_exort_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}

	return funcs
end
function modifier_invoker_exort_lua:GetModifierPreAttack_BonusDamage()
	return self.damage
end