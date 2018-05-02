lion_finger_of_death_lua = class({})
LinkLuaModifier( "modifier_lion_finger_of_death_lua", "lua_abilities/lion_finger_of_death_lua/modifier_lion_finger_of_death_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function lion_finger_of_death_lua:GetAOERadius()
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "splash_radius_scepter" )
	end

	return 0
end

function lion_finger_of_death_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

function lion_finger_of_death_lua:GetManaCost( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "mana_cost_scepter" )
	end

	return self.BaseClass.GetManaCost( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function lion_finger_of_death_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- pre-effects
	local sound_cast = "Hero_Lion.FingerOfDeath"
	EmitSoundOn( sound_cast, caster )

	-- cancel if linken
	if target:TriggerSpellAbsorb(self) then
		self:PlayEffects( target )
		return 
	end

	-- load data
	local delay = self:GetSpecialValueFor("damage_delay")
	local search = self:GetSpecialValueFor("splash_radius_scepter")

	-- find targets
	local targets = {}
	if caster:HasScepter() then
		targets = FindUnitsInRadius(
			caster:GetTeamNumber(),	-- int, your team number
			target:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			search,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)
	else
		table.insert(targets,target)
	end

	for _,enemy in pairs(targets) do
		-- delay
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_lion_finger_of_death_lua", -- modifier name
			{ duration = delay } -- kv
		)

		-- effects
		self:PlayEffects( enemy )
	end
end

--------------------------------------------------------------------------------
function lion_finger_of_death_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_finger_of_death.vpcf"
	local sound_cast = "Hero_Lion.FingerOfDeathImpact"

	-- load data
	local caster = self:GetCaster()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, caster )
	local attach = "attach_attack1"
	if caster:ScriptLookupAttachment( "attach_attack2" )~=0 then attach = "attach_attack2" end
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		attach,
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, target:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 3, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 3, (target:GetOrigin()-caster:GetOrigin()):Normalized() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end