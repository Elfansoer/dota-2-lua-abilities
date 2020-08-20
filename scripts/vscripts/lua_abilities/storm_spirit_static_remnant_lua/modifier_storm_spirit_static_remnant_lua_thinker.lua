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
modifier_storm_spirit_static_remnant_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_static_remnant_lua_thinker:IsHidden()
	return false
end

function modifier_storm_spirit_static_remnant_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_static_remnant_lua_thinker:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	-- references
	self.trigger = self:GetAbility():GetSpecialValueFor( "static_remnant_radius" )
	self.radius = self:GetAbility():GetSpecialValueFor( "static_remnant_damage_radius" )
	local damage = self:GetAbility():GetSpecialValueFor( "static_remnant_damage" )
	local delay = self:GetAbility():GetSpecialValueFor( "static_remnant_delay" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	self.tick = 0.1
	self.vision = 500
	self.team = self.caster:GetTeamNumber()
	self.origin = self.parent:GetOrigin()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( delay )

	self:PlayEffects()
end

function modifier_storm_spirit_static_remnant_lua_thinker:OnRefresh( kv )
end

function modifier_storm_spirit_static_remnant_lua_thinker:OnRemoved()
end

function modifier_storm_spirit_static_remnant_lua_thinker:OnDestroy()
	if not IsServer() then return end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.team,	-- int, your team number
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
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end

	-- play effects
	local sound_cast = "Hero_StormSpirit.StaticRemnantExplode"
	EmitSoundOn( sound_cast, self.parent )

	-- delete
	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_storm_spirit_static_remnant_lua_thinker:OnIntervalThink()
	if not self.active then
		self.active = true
		self:StartIntervalThink( self.tick )
	end

	-- vision
	AddFOWViewer( self.team, self.origin, self.vision, self.tick, false )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.team,	-- int, your team number
		self.origin,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.trigger,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #enemies>0 then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_storm_spirit_static_remnant_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_static_remnant.vpcf"
	local sound_cast = "Hero_StormSpirit.StaticRemnantPlant"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 0, self.caster:GetForwardVector() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.caster,
		PATTACH_POINT,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( ACT_DOTA_CAST_ABILITY_1, 1, 0 ) )

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