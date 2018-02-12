modifier_ursa_enrage_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:IsHidden()
	return false
end

function modifier_ursa_enrage_lua:IsDebuff()
	return false
end

function modifier_ursa_enrage_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:OnCreated( kv )
	-- get reference
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.stack_multiplier = self:GetAbility():GetSpecialValueFor("enrage_multiplier")

	-- change fury swipes modifier
	if IsServer() then
		local modifier = self:GetParent():FindModifierByNameAndCaster("modifier_ursa_fury_swipes_lua", self:GetAbility():GetCaster())
		if modifier~=nil then
			modifier.damage_per_stack = modifier:GetAbility():GetSpecialValueFor("damage_per_stack") * self.stack_multiplier
		end
	end
end

function modifier_ursa_enrage_lua:OnRefresh( kv )
	-- get reference
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.stack_multiplier = self:GetAbility():GetSpecialValueFor("enrage_multiplier")

	-- change fury swipes modifier
	if IsServer() then
		local modifier = self:GetParent():FindModifierByNameAndCaster("modifier_ursa_fury_swipes_lua", self:GetAbility():GetCaster())
		if modifier~=nil then
			modifier.damage_per_stack = modifier:GetAbility():GetSpecialValueFor("damage_per_stack") * self.stack_multiplier
		end
	end
end

function modifier_ursa_enrage_lua:OnDestroy( kv )
	-- get reference
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.stack_multiplier = self:GetAbility():GetSpecialValueFor("enrage_multiplier")

	-- change fury swipes modifier
	if IsServer() then
		local modifier = self:GetParent():FindModifierByNameAndCaster("modifier_ursa_fury_swipes_lua", self:GetAbility():GetCaster())
		if modifier~=nil then
			modifier.damage_per_stack = modifier:GetAbility():GetSpecialValueFor("damage_per_stack")
		end
	end
end
--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,

		MODIFIER_PROPERTY_MODEL_SCALE,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ursa_enrage_lua:GetModifierIncomingDamage_Percentage( params )
	return -self.damage_reduction
end

function modifier_ursa_enrage_lua:GetModifierModelScale( params )
	return 30
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_ursa_enrage_lua:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_ursa_enrage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end