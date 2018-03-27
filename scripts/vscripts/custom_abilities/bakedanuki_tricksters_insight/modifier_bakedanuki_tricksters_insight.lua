modifier_bakedanuki_tricksters_insight = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_bakedanuki_tricksters_insight:IsHidden()
	return false
end

function modifier_bakedanuki_tricksters_insight:IsDebuff()
	return true
end

function modifier_bakedanuki_tricksters_insight:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_bakedanuki_tricksters_insight:OnCreated( kv )

end

function modifier_bakedanuki_tricksters_insight:OnRefresh( kv )
	
end

function modifier_bakedanuki_tricksters_insight:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_bakedanuki_tricksters_insight:CheckState()
	local state = {
	[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_bakedanuki_tricksters_insight:GetEffectName()
	return "particles/units/heroes/hero_dark_willow/dark_willow_wisp_spell_debuff.vpcf"
end

function modifier_bakedanuki_tricksters_insight:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end