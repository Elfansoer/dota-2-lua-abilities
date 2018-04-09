modifier_sandra_heal_without_heal = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_heal_without_heal:IsHidden()
	return false
end

function modifier_sandra_heal_without_heal:IsDebuff()
	return false
end

function modifier_sandra_heal_without_heal:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_sandra_heal_without_heal:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_heal_without_heal:OnCreated( kv )
	if IsServer() then
		-- references
		self.regen = kv.damage/kv.duration
		self:SetStackCount( self.regen )
	end
	if not IsServer() then
		self.regen = self:GetStackCount()
	end
end

function modifier_sandra_heal_without_heal:OnRefresh( kv )

end

function modifier_sandra_heal_without_heal:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_heal_without_heal:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_sandra_heal_without_heal:GetModifierConstantHealthRegen()
	return self.regen
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_heal_without_heal:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf"
end

function modifier_sandra_heal_without_heal:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end