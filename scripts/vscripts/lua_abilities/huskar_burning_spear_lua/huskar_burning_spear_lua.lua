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
huskar_burning_spear_lua = class({})
LinkLuaModifier( "modifier_huskar_burning_spear_lua", "lua_abilities/huskar_burning_spear_lua/modifier_huskar_burning_spear_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_huskar_burning_spear_lua_stack", "lua_abilities/huskar_burning_spear_lua/modifier_huskar_burning_spear_lua_stack", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function huskar_burning_spear_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

--------------------------------------------------------------------------------
-- Orb Effects
function huskar_burning_spear_lua:GetProjectileName()
	return "particles/units/heroes/hero_huskar/huskar_burning_spear.vpcf"
end

function huskar_burning_spear_lua:OnOrbFire( params )
	-- health cost
	local damageTable = {
		victim = self:GetCaster(),
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor("health_cost"),
		damage_type = DAMAGE_TYPE_PURE,
		ability = self, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL + DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS, --Optional.
	}
	ApplyDamage(damageTable)
end

function huskar_burning_spear_lua:OnOrbImpact( params )
	local duration = self:GetDuration()

	params.target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_huskar_burning_spear_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Huskar.Burning_Spear.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Start
function huskar_burning_spear_lua:OnSpellStart()
end