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
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_shadow_fiend_shadowraze_lua:OnRefresh( kv )
	if IsServer() then
	end
end
