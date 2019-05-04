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
test_vector_target = class({})
LinkLuaModifier( "modifier_test_vector_target", "lua_abilities/test_vector_target/modifier_test_vector_target", LUA_MODIFIER_MOTION_NONE )


function test_vector_target:GetBehavior()
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_VECTOR_TARGETING
end

--------------------------------------------------------------------------------
-- Make Vector Targeting work
test_vector_target.position_init = nil
test_vector_target.position_end = nil
test_vector_target.first_cast = true
test_vector_target.prev_time = 0
function test_vector_target:CastFilterResultLocation( loc )
	if IsServer() then
		-- if reached this part, it must be first cast
		self.first_cast = true

		-- check time elapsed. If it is bigger than last frame time, assumed that it is a new cast
		local a = GameRules:GetGameTime()-self.prev_time
		local b = GameRules:GetGameFrameTime()
		if a>b then
			-- reset start and end position
			self.position_init = nil
		end
		self.prev_time = GameRules:GetGameTime()

		-- check if init is nil
		if not self.position_init then
			self.position_init = loc			
		else
			self.position_end = loc
		end

	end
	
	return UF_SUCCESS
end

function test_vector_target:OnAbilityPhaseStart()
	if self.first_cast then
		-- cast second time
		self:GetCaster():CastAbilityOnPosition( self.position_init, self, self:GetCaster():GetPlayerOwnerID() )
		self:PlayEffects2( self.position_init )

		-- not first cast anymore
		self.first_cast = false

		return false
	else
		-- second cast
		return true
	end
end

function test_vector_target:GetCastRange( loc, target )
	if self.first_cast then
		return 0
	end
	return self.BaseClass.GetCastRange( self, loc, target )
end

function test_vector_target:GetCastPoint()
	return 0
end

--------------------------------------------------------------------------------
-- Ability Start
function test_vector_target:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	self:PlayEffects( self.position_init, 100 )
	self:PlayEffects( self.position_end, 100 )
	
	self.position_init = nil
	self.position_end = nil
end

function test_vector_target:PlayEffects( position, radius )
	-- get resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"

	-- local radius = 100

	-- create particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, position )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function test_vector_target:PlayEffects2( position )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tinker/tinker_motm.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, position )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end