modifier_rubick_spell_steal_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_rubick_spell_steal_lua:IsHidden()
	return false
end

function modifier_rubick_spell_steal_lua:IsDebuff()
	return false
end

function modifier_rubick_spell_steal_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_rubick_spell_steal_lua:OnCreated( kv )
	-- -- references
	-- self.special_value = self:GetAbility():GetSpecialValueFor( "special_value" ) -- special value

	-- -- Start interval
	-- self:StartIntervalThink( self.interval )
	-- self:OnIntervalThink()
end

function modifier_rubick_spell_steal_lua:OnRefresh( kv )
	
end

function modifier_rubick_spell_steal_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
-- function modifier_rubick_spell_steal_lua:DeclareFunctions()
-- 	local funcs = {
-- 		MODIFIER_PROPERTY_XX,
-- 		MODIFIER_EVENT_YY,
-- 	}

-- 	return funcs
-- end

--------------------------------------------------------------------------------
-- Status Effects
-- function modifier_rubick_spell_steal_lua:CheckState()
-- 	local state = {
-- 	[MODIFIER_STATE_XX] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Interval Effects
-- function modifier_rubick_spell_steal_lua:OnIntervalThink()
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_rubick_spell_steal_lua:GetEffectName()
-- 	return "particles/string/here.vpcf"
-- end

-- function modifier_rubick_spell_steal_lua:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end