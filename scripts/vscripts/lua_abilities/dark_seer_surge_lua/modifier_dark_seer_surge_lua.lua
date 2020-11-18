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
modifier_dark_seer_surge_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_surge_lua:IsHidden()
	return false
end

function modifier_dark_seer_surge_lua:IsDebuff()
	return false
end

function modifier_dark_seer_surge_lua:IsStunDebuff()
	return false
end

function modifier_dark_seer_surge_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_surge_lua:OnCreated( kv )
	-- references
	self.speed = self:GetAbility():GetSpecialValueFor( "speed_boost" )

	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Dark_Seer.Surge"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_dark_seer_surge_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dark_seer_surge_lua:OnRemoved()
end

function modifier_dark_seer_surge_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dark_seer_surge_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_dark_seer_surge_lua:GetModifierMoveSpeedBonus_Constant()
	return self.speed
end

function modifier_dark_seer_surge_lua:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_dark_seer_surge_lua:GetActivityTranslationModifiers()
	return "haste"
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dark_seer_surge_lua:CheckState()
	local state = {
		[MODIFIER_STATE_UNSLOWABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_seer_surge_lua:GetEffectName()
	return "particles/units/heroes/hero_dark_seer/dark_seer_surge.vpcf"
end

function modifier_dark_seer_surge_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end