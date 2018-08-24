earth_spirit_rolling_boulder_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_rolling_boulder_lua", "lua_abilities/earth_spirit_rolling_boulder_lua/modifier_earth_spirit_rolling_boulder_lua", LUA_MODIFIER_MOTION_HORIZONTAL )
LinkLuaModifier( "modifier_earth_spirit_rolling_boulder_lua_slow", "lua_abilities/earth_spirit_rolling_boulder_lua/modifier_earth_spirit_rolling_boulder_lua_slow", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_rolling_boulder_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- set direction
	local direction = point-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()
	self.direction = direction

	-- add modifier
	self.modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earth_spirit_rolling_boulder_lua", -- modifier name
		{
			x = direction.x,
			y = direction.y,
		} -- kv
	)

	-- Play effects
	local sound_cast = "Hero_EarthSpirit.RollingBoulder.Cast"
	EmitSoundOn( sound_cast, caster )
end
--------------------------------------------------------------------------------
-- Projectile
function earth_spirit_rolling_boulder_lua:OnProjectileHitHandle( target, location, iHandle )
	if not IsServer() then return end
	if not target then return end

	-- get data
	local rock_speed = self:GetSpecialValueFor( "rock_speed" )
	local rock_distance = self:GetSpecialValueFor( "rock_distance" )
	local damage = self:GetSpecialValueFor( "damage" )
	local slow_duration = self:GetSpecialValueFor( "slow_duration" )

	-- check if remnant
	local remnant = target:FindModifierByName( "modifier_earth_spirit_stone_remnant_lua" )
	if remnant then
		-- destroy remnant
		remnant:Destroy()

		-- roll further
		ProjectileManager:UpdateLinearProjectileDirection( iHandle, self.direction*rock_speed, rock_distance )
		self.modifier:Upgrade()
		self.upgrade = true
	end

	-- unit filter
	local filter = UnitFilter(
		target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		self:GetCaster():GetTeamNumber()
	)
	if filter~=UF_SUCCESS then
		-- nothing happened
		return false
	end

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- if hero, stops
	if target:IsConsideredHero() then
		-- destroy rolling modifier
		if self.modifier and (not self.modifier:IsNull()) then
			self.modifier:End( self:GetCaster():GetOrigin() )
			self.modifier = nil
		end

		-- move to behind target
		self:GetCaster():SetOrigin( target:GetOrigin() + self.direction*80 )

		-- apply slow if upgraded
		if self.upgrade then
			self.upgrade = nil

			target:AddNewModifier(
				self:GetCaster(), -- player source
				self, -- ability source
				"modifier_earth_spirit_rolling_boulder_lua_slow", -- modifier name
				{ duration = slow_duration } -- kv
			)
		end

		return true
	end
end