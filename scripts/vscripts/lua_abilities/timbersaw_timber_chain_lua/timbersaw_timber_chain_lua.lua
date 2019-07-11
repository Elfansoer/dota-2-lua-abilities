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
timbersaw_timber_chain_lua = class({})
LinkLuaModifier( "modifier_timbersaw_timber_chain_lua", "lua_abilities/timbersaw_timber_chain_lua/modifier_timbersaw_timber_chain_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Ability Start
function timbersaw_timber_chain_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_speed = self:GetSpecialValueFor( "speed" )
	local projectile_distance = self:GetSpecialValueFor( "range" )
	local projectile_radius = self:GetSpecialValueFor( "radius" )
	local projectile_direction = point-caster:GetOrigin()
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local tree_radius = self:GetSpecialValueFor( "chain_radius" )
	local vision = 100

	-- create effect
	local effect = self:PlayEffects( caster:GetOrigin() + projectile_direction * projectile_distance, projectile_speed, projectile_distance/projectile_speed )

	-- create projectile
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    EffectName = "",
	    fDistance = projectile_distance,
	    fStartRadius = projectile_radius,
	    fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		fExpireTime = GameRules:GetGameTime() + 10.0,
		
		bProvidesVision = true,
		iVisionRadius = vision,
		iVisionTeamNumber = caster:GetTeamNumber(),
	}

	-- register projectile
	local projectile = ProjectileManager:CreateLinearProjectile(info)
	local ExtraData = {
		effect = effect,
		radius = tree_radius,
	}
	self.projectiles[ projectile ] = ExtraData
end
--------------------------------------------------------------------------------
-- Projectile
timbersaw_timber_chain_lua.projectiles = {}
function timbersaw_timber_chain_lua:OnProjectileThinkHandle( handle )
	-- get data
	local ExtraData = self.projectiles[ handle ]
	local location = ProjectileManager:GetLinearProjectileLocation( handle )

	-- search for tree
	local trees = GridNav:GetAllTreesAroundPoint( location, ExtraData.radius, false )

	if #trees>0 then
		local point = trees[1]:GetOrigin()

		-- snag
		self:GetCaster():AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_timbersaw_timber_chain_lua", -- modifier name
			{
				point_x = point.x,
				point_y = point.y,
				point_Z = point.z,
				effect = ExtraData.effect,
			} -- kv
		)

		-- modify effects
		self:ModifyEffects2( ExtraData.effect, point )

		-- destroy projectile
		ProjectileManager:DestroyLinearProjectile( handle )
		self.projectiles[ handle ] = nil
	end
end

function timbersaw_timber_chain_lua:OnProjectileHitHandle( target, location, handle )
	local ExtraData = self.projectiles[ handle ]
	if not ExtraData then return end

	-- play effect
	self:ModifyEffects1( ExtraData.effect )

	-- destroy reference
	self.projectiles[ handle ] = nil
end

--------------------------------------------------------------------------------
function timbersaw_timber_chain_lua:PlayEffects( point, speed, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_shredder/shredder_timberchain.vpcf"
	local sound_cast = "Hero_Shredder.TimberChain.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, point )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( speed, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( duration*2 + 0.3, 0, 0 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )

	return effect_cast
end

function timbersaw_timber_chain_lua:ModifyEffects1( effect )
	-- retract
	ParticleManager:SetParticleControlEnt(
		effect,
		1,
		self:GetCaster(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect )

	-- play sound
	local sound_cast = "Hero_Shredder.TimberChain.Retract"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function timbersaw_timber_chain_lua:ModifyEffects2( effect, point )
	-- set particle location
	ParticleManager:SetParticleControl( effect, 1, point )

	-- increase effect duration
	ParticleManager:SetParticleControl( effect, 3, Vector( 20, 0, 0 ) )

	-- play sound
	local sound_cast = "Hero_Shredder.TimberChain.Retract"
	local sound_target = "Hero_Shredder.TimberChain.Impact"
	EmitSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOnLocationWithCaster( point, sound_target, self:GetCaster() )
end

