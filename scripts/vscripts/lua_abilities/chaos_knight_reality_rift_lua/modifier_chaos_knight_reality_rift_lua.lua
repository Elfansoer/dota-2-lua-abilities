modifier_chaos_knight_reality_rift_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_chaos_knight_reality_rift_lua:IsHidden()
	return false
end

function modifier_chaos_knight_reality_rift_lua:IsDebuff()
	return true
end

function modifier_chaos_knight_reality_rift_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_chaos_knight_reality_rift_lua:OnCreated( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_chaos_knight_reality_rift_lua:OnRefresh( kv )
	-- references
	self.reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" )
end

function modifier_chaos_knight_reality_rift_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_chaos_knight_reality_rift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_chaos_knight_reality_rift_lua:GetModifierPhysicalArmorBonus()
	return self.reduction
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_chaos_knight_reality_rift_lua:GetEffectName()
	return "particles/items2_fx/medallion_of_courage.vpcf"
end

function modifier_chaos_knight_reality_rift_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end