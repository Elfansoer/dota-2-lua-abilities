-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_naga_siren_ensnare_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_ensnare_lua:IsHidden()
	return false
end

function modifier_naga_siren_ensnare_lua:IsDebuff()
	return true
end

function modifier_naga_siren_ensnare_lua:IsStunDebuff()
	return false
end

function modifier_naga_siren_ensnare_lua:IsPurgable()
	return true
end

function modifier_naga_siren_ensnare_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_ensnare_lua:OnCreated( kv )

end

function modifier_naga_siren_ensnare_lua:OnRefresh( kv )
	
end

function modifier_naga_siren_ensnare_lua:OnRemoved()
end

function modifier_naga_siren_ensnare_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_naga_siren_ensnare_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_naga_siren_ensnare_lua:GetEffectName()
	return "particles/units/heroes/hero_siren/siren_net.vpcf"
end

function modifier_naga_siren_ensnare_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end