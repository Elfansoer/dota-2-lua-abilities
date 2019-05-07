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
fairy_queen_enchantment = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_custom_indicator", "lua_abilities/generic/modifier_generic_custom_indicator", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_enchantment", "custom_abilities/fairy_queen_enchantment/modifier_fairy_queen_enchantment", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_enchantment_debuff", "custom_abilities/fairy_queen_enchantment/modifier_fairy_queen_enchantment_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_fairy_queen_enchantment_visual", "custom_abilities/fairy_queen_enchantment/modifier_fairy_queen_enchantment_visual", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function fairy_queen_enchantment:GetIntrinsicModifierName()
	-- Using custom indicator
	return "modifier_generic_custom_indicator"
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function fairy_queen_enchantment:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function fairy_queen_enchantment:CastFilterResultLocation( vLoc )
	-- Custom indicator block start
	if IsClient() then
		-- check custom indicator
		if self.custom_indicator then
			-- register cursor position
			self.custom_indicator:Register( vLoc )
		end
	end
	-- Custom indicator block end

	if not self:CheckFairies() then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function fairy_queen_enchantment:GetCustomCastErrorLocation( vLoc )
	if not self:CheckFairies() then
		return "#dota_hud_error_no_fairies"
	end

	return ""
end

function fairy_queen_enchantment:CheckFairies()
	if self:GetCaster():HasModifier( "modifier_fairy_queen_fairies" ) and self:GetCaster():HasModifier( "modifier_fairy_queen_fairies_counter" ) then
		local used = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )
		local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies", self:GetCaster() )
		if used<=fairies then
			return true
		end
	end

	return false
end

--------------------------------------------------------------------------------
-- Ability Custom Indicator
function fairy_queen_enchantment:CreateCustomIndicator()
	local ally_radius = self:GetSpecialValueFor( "ally_radius" )
	local enemy_radius = self:GetSpecialValueFor( "enemy_radius" )
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt_core_glow.vpcf"

	-- create particle
	self.effect_cast = {}
	for i=1,3 do
		self.effect_cast[i] = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
		ParticleManager:SetParticleShouldCheckFoW( self.effect_cast[i], false )
	end
end

function fairy_queen_enchantment:UpdateCustomIndicator( loc )
	-- get data
	local fairies = self:GetCaster():GetModifierStackCount( "modifier_fairy_queen_fairies_counter", self:GetCaster() )
	local max_range = self:GetSpecialValueFor("range")
	local radius = 100

	-- determine fairy location
	local base_vector = Vector(0,radius,0)
	local vectors = {}
	for i=1,3 do
		local split = 360/fairies
		vectors[i] = RotatePosition( Vector(0,0,0), QAngle( 0, split*(i-1), 0 ), base_vector )

		-- set fairy location
		ParticleManager:SetParticleControl( self.effect_cast[i], 0, loc+vectors[i] )
		ParticleManager:SetParticleControl( self.effect_cast[i], 3, loc+vectors[i] )
	end
end

function fairy_queen_enchantment:DestroyCustomIndicator()
	-- destroy
	for i=1,3 do
		ParticleManager:DestroyParticle( self.effect_cast[i], false )
		ParticleManager:ReleaseParticleIndex( self.effect_cast[i] )
		self.effect_cast[i] = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Start
function fairy_queen_enchantment:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- consume fairies
	local fairy_modifier = caster:FindModifierByNameAndCaster( "modifier_fairy_queen_fairies", caster )
	local fairies,fairy_visual = fairy_modifier:GetFairies()
	for _,visual in pairs(fairy_visual) do
		visual:DestroyFairy()
	end
	
	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	local radius = self:GetSpecialValueFor( "radius" )

	-- give vision
	AddFOWViewer( caster:GetTeamNumber(), point, radius, duration, false )

	if fairies>=2 then
		-- create buff thinker
		CreateModifierThinker(
			caster, -- player source
			self, -- ability source
			"modifier_fairy_queen_enchantment", -- modifier name
			{ duration = duration }, -- kv
			point,
			caster:GetTeamNumber(),
			false
		)
	end

	if fairies>=3 then
		-- create debuff thinker
		CreateModifierThinker(
			caster, -- player source
			self, -- ability source
			"modifier_fairy_queen_enchantment_debuff", -- modifier name
			{ duration = duration }, -- kv
			point,
			caster:GetTeamNumber(),
			false
		)
	end

	-- create visual
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_fairy_queen_enchantment_visual", -- modifier name
		{
			duration = duration,
			fairies = fairies,
		}, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)

	-- Create Sound
	local sound_cast = "Hero_SkywrathMage.AncientSeal.Target"
	EmitSoundOnLocationWithCaster( point, sound_cast, caster )
end