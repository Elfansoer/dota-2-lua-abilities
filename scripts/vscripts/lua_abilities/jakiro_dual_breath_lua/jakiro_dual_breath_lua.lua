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
jakiro_dual_breath_lua = class({})
LinkLuaModifier( "modifier_jakiro_dual_breath_lua", "lua_abilities/jakiro_dual_breath_lua/modifier_jakiro_dual_breath_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_lua_fire", "lua_abilities/jakiro_dual_breath_lua/modifier_jakiro_dual_breath_lua_fire", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_dual_breath_lua_ice", "lua_abilities/jakiro_dual_breath_lua/modifier_jakiro_dual_breath_lua_ice", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function jakiro_dual_breath_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local delay = self:GetSpecialValueFor( "fire_delay" )

	-- set position
	if target then
		point = target:GetOrigin()
	end

	-- create modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_jakiro_dual_breath_lua", -- modifier name
		{
			duration = delay,
			x = point.x,
			y = point.y,
		} -- kv
	)

end
--------------------------------------------------------------------------------
-- Projectile
function jakiro_dual_breath_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end

	-- load data
	local caster = self:GetCaster()
	local delay = self:GetSpecialValueFor( "fire_delay" )
	local duration = self:GetDuration()

	-- determine which breath
	local modifier = "modifier_jakiro_dual_breath_lua_ice"
	if data.fire==1 then modifier = "modifier_jakiro_dual_breath_lua_fire" end

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		modifier, -- modifier name
		{ duration = duration } -- kv
	)
end