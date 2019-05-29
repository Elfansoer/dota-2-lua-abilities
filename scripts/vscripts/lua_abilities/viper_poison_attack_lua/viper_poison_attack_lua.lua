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
viper_poison_attack_lua = class({})
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_viper_poison_attack_lua", "lua_abilities/viper_poison_attack_lua/modifier_viper_poison_attack_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function viper_poison_attack_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

--------------------------------------------------------------------------------
-- Orb Effects
function viper_poison_attack_lua:GetProjectileName()
	return "particles/units/heroes/hero_viper/viper_poison_attack.vpcf"
end

function viper_poison_attack_lua:OnOrbFire( params )
	-- play effects
	local sound_cast = "hero_viper.poisonAttack.Cast"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function viper_poison_attack_lua:OnOrbImpact( params )
	-- references
	local duration = self:GetSpecialValueFor( "duration" )

	-- add debuff
	params.target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_viper_poison_attack_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "hero_viper.poisonAttack.Target"
	EmitSoundOn( sound_cast, self:GetCaster() )
end