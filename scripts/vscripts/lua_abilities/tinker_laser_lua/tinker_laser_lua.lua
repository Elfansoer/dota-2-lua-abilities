tinker_laser_lua = class({})
LinkLuaModifier( "modifier_tinker_laser_lua", "lua_abilities/tinker_laser_lua/modifier_tinker_laser_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function tinker_laser_lua:OnAbilityPhaseStart()
	-- effects
	local sound_cast = "Hero_Tinker.LaserAnim"
	EmitSoundOn( sound_cast, self:GetCaster() )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function tinker_laser_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if Linken
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- load data
	local duration_hero = self:GetSpecialValueFor("some_value")
	local duration_creep = self:GetSpecialValueFor("some_value")
	local damage = self:GetSpecialValueFor("laser_damage")

	-- get targets
	local targets = {}
	table.insert( targets, target )
	if caster:HasScepter() then
		self:Refract( targets, 1 )
	end

	-- precache damage
	local damage = {
		-- victim = hTarget,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self
	}
	for _,enemy in pairs(targets) do
		-- apply damage
		damage.victim = enemy
		ApplyDamage( damage )

		-- add modifier
		local duration = duration_hero
		if enemy:IsCreep() then
			duration = duration_creep
		end
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_tinker_laser_lua", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- effects
	self:PlayEffects( targets )
end

function tinker_laser_lua:Refract( targets, jumps )
	-- load data
	local scepter_range = self:GetSpecialValueFor("scepter_bounce_range")

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		targets[jumps]:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		scepter_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- check for valid closest not-yet-affected next target 
	local next_target = nil
	for _,enemy in pairs(enemies) do
		local candidate = true
		for _,target in pairs(targets) do
			if enemy==target then
				candidate = false
				break
			end
		end
		if candidate then
			next_target = enemy
			break
		end
	end

	-- recursive
	if next_target then
		table.insert( targets, next_target )
		self:Refract( targets, jumps+1 )
	end
end

--------------------------------------------------------------------------------
function tinker_laser_lua:PlayEffects( targets )
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "Hero_Tinker.Laser"
	local sound_target = "Hero_Tinker.LaserImpact"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
	for _,target in pairs(targets) do
		EmitSoundOn( sound_target, target )
	end
end