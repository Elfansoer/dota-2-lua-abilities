modifier_omniknight_repel_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_omniknight_repel_lua:IsHidden()
	return false
end

function modifier_omniknight_repel_lua:IsDebuff()
	return false
end

function modifier_omniknight_repel_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_omniknight_repel_lua:OnCreated( kv )

end

function modifier_omniknight_repel_lua:OnRefresh( kv )
	
end

function modifier_omniknight_repel_lua:OnDestroy( kv )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_omniknight_repel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
	}

	return funcs
end

function modifier_omniknight_repel_lua:GetAbsoluteNoDamageMagical()
	return 1
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_omniknight_repel_lua:CheckState()
	local state = {
	[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_omniknight_repel_lua:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function modifier_omniknight_repel_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end