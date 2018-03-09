modifier_generic_bashed_lua = class({})

--------------------------------------------------------------------------------

function modifier_generic_bashed_lua:IsDebuff()
	return true
end

function modifier_generic_bashed_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_bashed_lua:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_generic_bashed_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_bashed_lua:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------

function modifier_generic_bashed_lua:GetEffectName()
	return "particles/generic_gameplay/generic_bashed.vpcf"
end

function modifier_generic_bashed_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
