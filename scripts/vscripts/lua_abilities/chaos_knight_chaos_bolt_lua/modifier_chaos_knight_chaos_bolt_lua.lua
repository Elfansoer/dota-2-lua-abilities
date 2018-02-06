modifier_chaos_knight_chaos_bolt_lua = class({})

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt_lua:IsDebuff()
	return true
end

function modifier_chaos_knight_chaos_bolt_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_chaos_knight_chaos_bolt_lua:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end