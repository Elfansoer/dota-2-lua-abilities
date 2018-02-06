modifier_shadow_fiend_shadowraze_lua = class({})

--------------------------------------------------------------------------------

function modifier_shadow_fiend_shadowraze_lua:IsHidden()
	return false
end

function modifier_shadow_fiend_shadowraze_lua:IsDebuff()
	return true
end

function modifier_shadow_fiend_shadowraze_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_shadow_fiend_shadowraze_lua:OnCreated( kv )
	self:SetStackCount(1)
end

function modifier_shadow_fiend_shadowraze_lua:OnRefresh( kv )

end

--------------------------------------------------------------------------------

function modifier_shadow_fiend_shadowraze_lua:GetEffectName()
	return "particles/units/heroes/hero_nevermore/nevermore_shadowraze_debuff.vpcf"
end

function modifier_shadow_fiend_shadowraze_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
--------------------------------------------------------------------------------