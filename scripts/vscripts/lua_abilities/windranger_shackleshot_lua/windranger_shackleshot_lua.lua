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
windranger_shackleshot_lua = class({})
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function windranger_shackleshot_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local projectile_name = "particles/units/heroes/hero_windrunner/windrunner_shackleshot.vpcf"
	local projectile_speed = self:GetSpecialValueFor( "arrow_speed" )

	-- store cast location
	local location = caster:GetOrigin()

	-- create projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional	

		ExtraData = {
			location_x = location.x,
			location_y = location.y,
			location_z = location.z,
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Windrunner.ShackleshotCast"
	EmitSoundOn( sound_cast, caster )
end
--------------------------------------------------------------------------------
-- Projectile
function windranger_shackleshot_lua:OnProjectileHit_ExtraData( target, location, ExtraData )
	if not target then return end

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- references
	local search_radius = self:GetSpecialValueFor( "shackle_distance" )
	local stun_duration = self:GetSpecialValueFor( "stun_duration" )
	local fail_duration = self:GetSpecialValueFor( "fail_stun_duration" )
	local search_angle = self:GetSpecialValueFor( "shackle_angle" )
	local search_count = self:GetSpecialValueFor( "shackle_count" )

	-- init data
	local shackled = 0
	local location = Vector( ExtraData.location_x, ExtraData.location_y, ExtraData.location_z )
	local target_origin = target:GetOrigin()
	local target_angle = VectorToAngles( target_origin-location ).y

	-- find nearby enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		search_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- ensure it is not the target herself
		if enemy~=target then

			-- check position angle
			local enemy_angle = VectorToAngles( enemy:GetOrigin()-target_origin ).y
			if math.abs( AngleDiff( target_angle, enemy_angle ) ) <= search_angle then
				shackled = shackled + 1

				-- stun both units
				target:AddNewModifier(
					self:GetCaster(), -- player source
					self, -- ability source
					"modifier_generic_stunned_lua", -- modifier name
					{ duration = stun_duration } -- kv
				)
				enemy:AddNewModifier(
					self:GetCaster(), -- player source
					self, -- ability source
					"modifier_generic_stunned_lua", -- modifier name
					{ duration = stun_duration } -- kv
				)

				-- play effects
				self:PlayEffects1( target, enemy, stun_duration )
			end

			-- in case multiple shackled units allowed
			if shackled>=search_count then break end

		end
	end
	if shackled>=search_count then return end

	-- if enemy not found, find trees
	local trees = GridNav:GetAllTreesAroundPoint( target_origin, search_radius, false )
	for _,tree in pairs(trees) do
		-- check position angle
		local tree_angle = VectorToAngles( tree:GetOrigin()-target_origin ).y
		if math.abs( AngleDiff( target_angle, tree_angle ) ) <= search_angle then
			shackled = shackled + 1

			-- stun target
			target:AddNewModifier(
				self:GetCaster(), -- player source
				self, -- ability source
				"modifier_generic_stunned_lua", -- modifier name
				{ duration = stun_duration } -- kv
			)

			-- Play effects
			self:PlayEffects2( target, tree:GetOrigin(), stun_duration )

			-- only one tree is enough
			break
		end
	end
	if shackled>=search_count then return end

	-- if no enemy or tree found, it's dud
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = fail_duration } -- kv
	)

	-- play effects
	local point = target_origin-location
	point.z = 0
	point = target_origin + point:Normalized()*search_radius
	self:PlayEffects3( target, point )
end

--------------------------------------------------------------------------------
function windranger_shackleshot_lua:PlayEffects1( target1, target2, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair.vpcf"
	local sound_cast = "Hero_Windrunner.ShackleshotBind"
	local sound_target = "Hero_Windrunner.ShackleshotStun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target1 )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target2,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target1 )
	EmitSoundOn( sound_target, target1 )
	EmitSoundOn( sound_target, target2 )
end

function windranger_shackleshot_lua:PlayEffects2( target, tree, duration )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_windrunner/windrunner_shackleshot_pair_tree.vpcf"
	local sound_cast = "Hero_Windrunner.ShackleshotBind"
	local sound_target = "Hero_Windrunner.ShackleshotStun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, tree )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
	EmitSoundOn( sound_target, target )
end

function windranger_shackleshot_lua:PlayEffects3( target, point )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_windrunner/windrunner_shackleshot_single.vpcf"
	local sound_cast = "Hero_Windrunner.ShackleshotStun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlForward( effect_cast, 2, (point-target:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end