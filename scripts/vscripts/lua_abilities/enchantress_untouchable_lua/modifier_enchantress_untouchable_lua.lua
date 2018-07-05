modifier_enchantress_untouchable_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enchantress_untouchable_lua:IsHidden()
	return true
end

function modifier_enchantress_untouchable_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enchantress_untouchable_lua:OnCreated( kv )

end

function modifier_enchantress_untouchable_lua:OnRefresh( kv )
	
end

function modifier_enchantress_untouchable_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_enchantress_untouchable_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
	}

	return funcs
end

function modifier_enchantress_untouchable_lua:OnAttackStart( params )
	if IsServer() then
		if params.target~=self:GetParent() then return end

		-- cancel if immune
		if params.attacker:IsMagicImmune() then return end

		-- cancel if break
		if self:GetParent():PassivesDisabled() then return end

		-- add modifier
		params.attacker:AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_enchantress_untouchable_lua_debuff", -- modifier name
			{  } -- kv
		)
	end
end