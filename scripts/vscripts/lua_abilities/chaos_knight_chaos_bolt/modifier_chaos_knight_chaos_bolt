modifier_chaos_knight_chaos_bolt = class({})

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt:IsDebuff()
	return true
end

function modifier_chaos_knight_chaos_bolt:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_chaos_knight_chaos_bolt:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
