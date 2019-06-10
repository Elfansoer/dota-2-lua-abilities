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
dark_willow_bedlam_lua = class({})
LinkLuaModifier( "modifier_wisp_ambient", "lua_abilities/dark_willow_bedlam_lua/modifier_wisp_ambient", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_bedlam_lua", "lua_abilities/dark_willow_bedlam_lua/modifier_dark_willow_bedlam_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_bedlam_lua_attack", "lua_abilities/dark_willow_bedlam_lua/modifier_dark_willow_bedlam_lua_attack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function dark_willow_bedlam_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "roaming_duration" )

	-- add buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dark_willow_bedlam_lua", -- modifier name
		{ duration = duration } -- kv
	)

end
--------------------------------------------------------------------------------
-- Projectile
function dark_willow_bedlam_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not target then return end

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = ExtraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)
end