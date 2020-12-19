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
modifier_hoodwink_scurry_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_scurry_lua_buff:IsHidden()
	return false
end

function modifier_hoodwink_scurry_lua_buff:IsDebuff()
	return false
end

function modifier_hoodwink_scurry_lua_buff:IsStunDebuff()
	return false
end

function modifier_hoodwink_scurry_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_scurry_lua_buff:OnCreated( kv )
	-- references
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed_pct" )

	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Hoodwink.Scurry.Cast"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_hoodwink_scurry_lua_buff:OnRefresh( kv )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed_pct" )	
end

function modifier_hoodwink_scurry_lua_buff:OnRemoved()
end

function modifier_hoodwink_scurry_lua_buff:OnDestroy()
	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Hoodwink.Scurry.End"
	EmitSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hoodwink_scurry_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_hoodwink_scurry_lua_buff:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hoodwink_scurry_lua_buff:CheckState()
	local state = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hoodwink_scurry_lua_buff:GetEffectName()
	return "particles/units/heroes/hero_hoodwink/hoodwink_scurry_aura.vpcf"
end

function modifier_hoodwink_scurry_lua_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end