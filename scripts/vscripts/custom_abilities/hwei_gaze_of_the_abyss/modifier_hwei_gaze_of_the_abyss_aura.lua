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
modifier_hwei_gaze_of_the_abyss_aura = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_gaze_of_the_abyss_aura:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "root_duration" )
	self.delay = self:GetAbility():GetSpecialValueFor( "delay" )
	self.interval = 0.1

	if not IsServer() then return end
	self.damage_type = self.ability:GetAbilityDamageType()

	self.is_delay = true

	-- Start interval
	self:StartIntervalThink( self.delay )

	self:PlayEffectsStart()
end

function modifier_hwei_gaze_of_the_abyss_aura:OnRefresh( kv )
end

function modifier_hwei_gaze_of_the_abyss_aura:OnRemoved()
end

function modifier_hwei_gaze_of_the_abyss_aura:OnDestroy()
	if not IsServer() then return end
	RemoveFOWViewer( self.caster:GetTeamNumber(), self.viewer )
	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hwei_gaze_of_the_abyss_aura:OnIntervalThink()
	if self.is_delay then
		self:StartIntervalThink(self.interval)
		self.is_delay = false

		self.viewer = AddFOWViewer(
			self.caster:GetTeamNumber(),
			self.parent:GetOrigin(),
			self.radius,
			self:GetRemainingTime(),
			false
		)

		self:PlayEffectsActive()
		return
	end

	-- kill effect
	ParticleManager:DestroyParticle( self.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )

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

	local enemy = enemies[1]
	if enemy then
		-- root
		enemy:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_hwei_gaze_of_the_abyss",
			{duration = self.duration}
		)

		-- vision
		AddFOWViewer(
			self.caster:GetTeamNumber(),
			enemy:GetOrigin(),
			100,
			self.duration,
			false
		)

		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_gaze_of_the_abyss_aura:PlayEffectsStart()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice.Start"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 1, 1 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_hwei_gaze_of_the_abyss_aura:PlayEffectsActive()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self:GetDuration(), 0, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end