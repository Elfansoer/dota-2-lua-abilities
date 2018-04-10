modifier_sandra_ironical_healing = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sandra_ironical_healing:IsHidden()
	return false
end

function modifier_sandra_ironical_healing:IsDebuff()
	return false
end

function modifier_sandra_ironical_healing:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_sandra_ironical_healing:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sandra_ironical_healing:OnCreated( kv )
	if IsServer() then
		-- references
		self.regen = kv.damage/kv.duration
		self:SetStackCount( self.regen )
	end
	if not IsServer() then
		self.regen = self:GetStackCount()
	end
end

function modifier_sandra_ironical_healing:OnRefresh( kv )

end

function modifier_sandra_ironical_healing:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sandra_ironical_healing:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}

	return funcs
end

function modifier_sandra_ironical_healing:GetModifierConstantHealthRegen()
	return self.regen
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sandra_ironical_healing:GetEffectName()
	return "particles/units/heroes/hero_oracle/oracle_purifyingflames.vpcf"
end

function modifier_sandra_ironical_healing:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end