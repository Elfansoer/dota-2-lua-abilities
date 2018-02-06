modifier_ogre_magi_fireblast_lua = class({})

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast_lua:IsDebuff()
	return true
end

function modifier_ogre_magi_fireblast_lua:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast_lua:CheckState()
	local state = {
	    [MODIFIER_STATE_STUNNED] = true,
	}

	return state
end