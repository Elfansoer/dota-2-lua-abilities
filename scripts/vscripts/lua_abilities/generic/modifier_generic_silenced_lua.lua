modifier_generic_silenced_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_silenced_lua:IsDebuff()
	return true
end

function modifier_generic_silenced_lua:IsStunDebuff()
	return false
end

function modifier_generic_silenced_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Modifier State
function modifier_generic_silenced_lua:CheckState()
	local state = {
		[MODIFIER_STATE_SILENCED] = true,
	}

	return state
end