earth_spirit_magnetize_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_magnetize_lua", "lua_abilities/earth_spirit_magnetize_lua/modifier_earth_spirit_magnetize_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_earth_spirit_magnetize_lua_expire", "lua_abilities/earth_spirit_magnetize_lua/modifier_earth_spirit_magnetize_lua_expire", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_magnetize_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local radius = self:GetSpecialValueFor("cast_radius")
	local duration = self:GetSpecialValueFor("damage_duration")

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- apply modifier
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_earth_spirit_magnetize_lua", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- effects
	self:PlayEffects( radius )
end

--------------------------------------------------------------------------------
-- External function
earth_spirit_magnetize_lua.debuff_tracker = {}
function earth_spirit_magnetize_lua:AddDebuff( modifier )
	table.insert( self.debuff_tracker, modifier )
end

function earth_spirit_magnetize_lua:RemoveDebuff( modifier )
	for i,mod in pairs(self.debuff_tracker) do
		if mod==modifier then
			table.remove( self.debuff_tracker, i )
		end
	end
end

function earth_spirit_magnetize_lua:ApplyDebuff( ability, modifier_name, duration )
	for _,mod in pairs(self.debuff_tracker) do
		local parent = mod:GetParent()
		if parent:IsAlive() and (not parent:IsMagicImmune()) and (not parent:IsInvulnerable()) then
			parent:AddNewModifier(
				self:GetCaster(), -- player source
				ability, -- ability source
				modifier_name, -- modifier name
				{ duration = duration } -- kv
			)
		end
	end
end
--------------------------------------------------------------------------------
function earth_spirit_magnetize_lua:PlayEffects( radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_earth_spirit/espirit_magnetize_pulse.vpcf"
	local sound_cast = "Hero_EarthSpirit.Magnetize.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end