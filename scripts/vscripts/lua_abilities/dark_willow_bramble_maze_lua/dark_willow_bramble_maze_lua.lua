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
dark_willow_bramble_maze_lua = class({})
LinkLuaModifier( "modifier_generic_custom_indicator", "lua_abilities/generic/modifier_generic_custom_indicator", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_bramble_maze_lua_thinker", "lua_abilities/dark_willow_bramble_maze_lua/modifier_dark_willow_bramble_maze_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_bramble_maze_lua_bramble", "lua_abilities/dark_willow_bramble_maze_lua/modifier_dark_willow_bramble_maze_lua_bramble", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_dark_willow_bramble_maze_lua_debuff", "lua_abilities/dark_willow_bramble_maze_lua/modifier_dark_willow_bramble_maze_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- init bramble locations
local locations = {}
local inner = Vector( 200, 0, 0 )
local outer = Vector( 500, 0, 0 )
outer = RotatePosition( Vector(0,0,0), QAngle( 0, 45, 0 ), outer )

-- real men use 0-based
for i=0,3 do
	locations[i] = RotatePosition( Vector(0,0,0), QAngle( 0, 90*i, 0 ), inner )
	locations[i+4] = RotatePosition( Vector(0,0,0), QAngle( 0, 90*i, 0 ), outer )
end
dark_willow_bramble_maze_lua.locations = locations

--------------------------------------------------------------------------------
-- Passive Modifier
function dark_willow_bramble_maze_lua:GetIntrinsicModifierName()
	return "modifier_generic_custom_indicator"
end

--------------------------------------------------------------------------------
-- Ability Cast Filter (For custom indicator)
function dark_willow_bramble_maze_lua:CastFilterResultLocation( vLoc )
	-- Custom indicator block start
	if IsClient() then
		-- check custom indicator
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end
	-- Custom indicator block end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator
function dark_willow_bramble_maze_lua:CreateCustomIndicator()
	-- references
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_bramble_range_finder_aoe.vpcf"

	-- get data
	local radius = self:GetSpecialValueFor( "placement_range" )

	-- create particle
	self.effect_indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl( self.effect_indicator, 1, Vector( radius, radius, radius ) )
end

function dark_willow_bramble_maze_lua:UpdateCustomIndicator( loc )
	-- update particle position
	ParticleManager:SetParticleControl( self.effect_indicator, 0, loc )
	for i=0,7 do
		ParticleManager:SetParticleControl( self.effect_indicator, 2 + i, loc + self.locations[i] )
	end
end

function dark_willow_bramble_maze_lua:DestroyCustomIndicator()
	-- destroy particle
	ParticleManager:DestroyParticle( self.effect_indicator, false )
	ParticleManager:ReleaseParticleIndex( self.effect_indicator )
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_willow_bramble_maze_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_dark_willow_bramble_maze_lua_thinker", -- modifier name
		{}, -- kv
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)
end