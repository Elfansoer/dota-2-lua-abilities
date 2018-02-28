modifier_slardar_corrosive_haze_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slardar_corrosive_haze_lua:IsHidden()
	return false
end

function modifier_slardar_corrosive_haze_lua:IsDebuff()
	return true
end

function modifier_slardar_corrosive_haze_lua:IsStunDebuff()
	return false
end

function modifier_slardar_corrosive_haze_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slardar_corrosive_haze_lua:OnCreated( kv )
	-- references
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" ) -- special value
end

function modifier_slardar_corrosive_haze_lua:OnRefresh( kv )
	self.armor_reduction = self:GetAbility():GetSpecialValueFor( "armor_reduction" ) -- special value
end

function modifier_slardar_corrosive_haze_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_slardar_corrosive_haze_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_slardar_corrosive_haze_lua:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end

function modifier_slardar_corrosive_haze_lua:GetModifierProvidesFOWVision()
	return 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_slardar_corrosive_haze_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_slardar_corrosive_haze_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end
