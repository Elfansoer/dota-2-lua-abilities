modifier_ursa_fury_swipes_debuff_lua = class({})

--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_debuff_lua:IsHidden()
	return false
end

function modifier_ursa_fury_swipes_debuff_lua:IsDebuff()
	return true
end

function modifier_ursa_fury_swipes_debuff_lua:IsPurgable()
	return false
end
--------------------------------------------------------------------------------

function modifier_ursa_fury_swipes_debuff_lua:OnCreated( kv )
	self:SetStackCount(1)
end

function modifier_ursa_fury_swipes_debuff_lua:OnRefresh( kv )
end
