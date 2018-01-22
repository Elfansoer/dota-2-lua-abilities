modifier_ogre_magi_fireblast = class({})

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast:IsDebuff()
	return true
end

function modifier_ogre_magi_fireblast:IsStunDebuff()
	return true
end

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast:CheckState()
	local state = {
	    [MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

--------------------------------------------------------------------------------

function modifier_ogre_magi_fireblast:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_ogre_magi_fireblast:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

--------------------------------------------------------------------------------
