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
pangolier_swashbuckle_lua = class({})
LinkLuaModifier( "modifier_generic_knockback_lua", "lua_abilities/generic/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_pangolier_swashbuckle_lua", "lua_abilities/pangolier_swashbuckle_lua/modifier_pangolier_swashbuckle_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_vector_target", "lua_abilities/generic/modifier_generic_vector_target", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function pangolier_swashbuckle_lua:Spawn()
	-- register custom indicator
	if not IsServer() then
		CustomIndicator:RegisterAbility( self )
		return
	end
end

--------------------------------------------------------------------------------
-- Passive Modifier
function pangolier_swashbuckle_lua:GetIntrinsicModifierName()
	return "modifier_generic_vector_target"
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator (using CustomIndicator library, this section is Client Lua only)
function pangolier_swashbuckle_lua:CreateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local caster = self:GetCaster()

	-- primary cast position
	self.client_vector_position = position or self:GetCaster():GetAbsOrigin()

	-- create particle
	local particle_cast = "particles/ui_mouseactions/range_finder_cone.vpcf"
	self.indicator = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.indicator, 3, Vector( 125, 125, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 4, Vector( 0, 255, 0 ) )
	ParticleManager:SetParticleControl( self.indicator, 6, Vector( 1, 0, 0 ) )

	-- do logic that is similar to update func
	self:UpdateCustomIndicator( position, unit, behavior )
end

function pangolier_swashbuckle_lua:UpdateCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end

	-- get data
	local range = self:GetSpecialValueFor( "range" )
	local origin_pos = self.client_vector_position

	local direction = position - origin_pos
	direction.z = 0
	direction = direction:Normalized()

	local end_pos = origin_pos + direction * range

	-- update particle
	ParticleManager:SetParticleControl( self.indicator, 1, origin_pos )
	ParticleManager:SetParticleControl( self.indicator, 2, end_pos )
end

function pangolier_swashbuckle_lua:DestroyCustomIndicator( position, unit, behavior )
	if behavior~=DOTA_CLICK_BEHAVIOR_VECTOR_CAST then return end
	self.client_vector_position  = nil

	-- destroy particle
	ParticleManager:DestroyParticle(self.indicator, false)
	ParticleManager:ReleaseParticleIndex(self.indicator)
	self.indicator = nil
end

--------------------------------------------------------------------------------
-- Ability Start
function pangolier_swashbuckle_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector_point = self.vector_position

	-- load data
	local speed = self:GetSpecialValueFor( "dash_speed" )
	local direction = vector_point - point
	direction.z = 0
	direction = direction:Normalized()

	local vector = (point-caster:GetOrigin())
	local dist = vector:Length2D()
	vector.z = 0
	vector = vector:Normalized()

	-- Facing
	caster:SetForwardVector( direction )

	-- Play effects
	local effects = self:PlayEffects()

	-- knockback
	local knockback = caster:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			direction_x = vector.x,
			direction_y = vector.y,
			distance = dist,
			duration = dist/speed,
			IsStun = true,
			IsFlail = false,
		} -- kv
	)
	local callback = function( bInterrupted )
		-- stop effects
		ParticleManager:DestroyParticle( effects, false )
		ParticleManager:ReleaseParticleIndex( effects )

		if bInterrupted then return end

		-- add modifier
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_pangolier_swashbuckle_lua", -- modifier name
			{
				dir_x = direction.x,
				dir_y = direction.y,
				duration = 3, -- max duration
			} -- kv
		)
		
	end
	knockback:SetEndCallback( callback )
end

--------------------------------------------------------------------------------
function pangolier_swashbuckle_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf"
	local sound_cast = "Hero_Pangolier.Swashbuckle.Cast"
	local sound_layer = "Hero_Pangolier.Swashbuckle.Layer"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_layer, self:GetCaster() )

	return effect_cast
end