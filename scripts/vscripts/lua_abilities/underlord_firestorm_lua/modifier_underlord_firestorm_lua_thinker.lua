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
modifier_underlord_firestorm_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_firestorm_lua_thinker:IsHidden()
	return true
end

function modifier_underlord_firestorm_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_firestorm_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	local damage = self.ability:GetSpecialValueFor( "wave_damage" )
	local delay = self.ability:GetSpecialValueFor( "first_wave_delay" )
	self.radius = self.ability:GetSpecialValueFor( "radius" )
	self.count = self.ability:GetSpecialValueFor( "wave_count" )
	self.interval = self.ability:GetSpecialValueFor( "wave_interval" )

	self.burn_duration = self.ability:GetSpecialValueFor( "burn_duration" )
	self.burn_interval = self.ability:GetSpecialValueFor( "burn_interval" )
	self.burn_damage = self.ability:GetSpecialValueFor( "burn_damage" )

	if not IsServer() then return end

	-- init
	self.wave = 0
	self.damageTable = {
		-- victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( delay )
end

function modifier_underlord_firestorm_lua_thinker:OnRefresh( kv )
	
end

function modifier_underlord_firestorm_lua_thinker:OnRemoved()
end

function modifier_underlord_firestorm_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_underlord_firestorm_lua_thinker:OnIntervalThink()
	if not self.delayed then
		self.delayed = true
		self:StartIntervalThink( self.interval )
		self:OnIntervalThink()
		return
	end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- add debuff
		enemy:AddNewModifier(
			self.caster, -- player source
			self.ability, -- ability source
			"modifier_underlord_firestorm_lua", -- modifier name
			{
				duration = self.burn_duration,
				interval = self.burn_interval,
				damage = self.burn_damage,
			} -- kv
		)
	end

	-- play effects
	self:PlayEffects()

	-- count wave
	self.wave = self.wave + 1
	if self.wave>=self.count then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_underlord_firestorm_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( self.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end