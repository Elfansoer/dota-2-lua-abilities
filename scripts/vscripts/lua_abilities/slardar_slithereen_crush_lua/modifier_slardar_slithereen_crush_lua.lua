modifier_slardar_slithereen_crush_lua = class({})

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua:IsDebuff()
	return true
end

function modifier_slardar_slithereen_crush_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_slardar_slithereen_crush_lua:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end