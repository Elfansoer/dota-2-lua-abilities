earth_spirit_boulder_smash_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_boulder_smash_lua", "lua_abilities/earth_spirit_boulder_smash_lua/modifier_earth_spirit_boulder_smash_lua", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Custom KV
function earth_spirit_boulder_smash_lua:GetCastRange( vLocation, hTarget )
	if IsServer() then
		local radius = self:GetSpecialValueFor("rock_search_aoe")

		-- if there is remnant around caster, cast immediately (cast range become global)
		if self:SearchRemnant( self:GetCaster():GetOrigin(), radius ) then
			return 0
		end

		-- if not, walk to target
		return self.BaseClass.GetCastRange( self, vLocation, hTarget )
	end
end

--------------------------------------------------------------------------------
-- Custom cast
function earth_spirit_boulder_smash_lua:CastFilterResultTarget( hTarget )
	-- unable to target self
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter( hTarget, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP, DOTA_UNIT_TARGET_FLAG_NONE, self:GetCaster():GetTeamNumber() )
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_boulder_smash_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local distance = self:GetSpecialValueFor("unit_distance")
	local radius = self:GetSpecialValueFor("rock_search_aoe")

	-- find remnant in area
	local remnant = self:SearchRemnant( caster:GetOrigin(), radius )

	-- if remnant exists
	if remnant then
		-- set direction
		local dirX = point.x-caster:GetOrigin().x
		local dirY = point.y-caster:GetOrigin().y

		-- kick remnant
		self:Kick( remnant, dirX, dirY, distance )
	else
		-- check target exist
		if target then
			-- set direction
			dirX = target:GetOrigin().x-caster:GetOrigin().x
			dirY = target:GetOrigin().y-caster:GetOrigin().y

			-- kick target
			self:Kick( target, dirX, dirY, distance )
		else
			-- nothing happened.
			self:RefundManaCost()
			self:EndCooldown()
		end
	end

	-- play effects
	local sound_cast = "Hero_EarthSpirit.BoulderSmash.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
-- function earth_spirit_boulder_smash_lua:OnProjectileHit( target, location )
-- end

--------------------------------------------------------------------------------
-- Helpers
function earth_spirit_boulder_smash_lua:SearchRemnant( point, radius )
	-- find remnant in area
	local remnants = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		point,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_ALL,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local ret = nil
	for _,remnant in pairs(remnants) do
		if remnant:HasModifier( "modifier_earth_spirit_stone_remnant_lua" ) then
			return remnant
		end
	end
	return ret
end

function earth_spirit_boulder_smash_lua:Kick( target, x, y, r )
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_earth_spirit_boulder_smash_lua", -- modifier name
		{
			x = x,
			y = y,
			r = r,
		} -- kv
	)

	-- play effects
	local sound_target = "Hero_EarthSpirit.BoulderSmash.Target"
	EmitSoundOn( sound_target, target )
end
--------------------------------------------------------------------------------
-- function earth_spirit_boulder_smash_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end