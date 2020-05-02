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
modifier_jakiro_macropyre_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_jakiro_macropyre_lua_thinker:IsHidden()
	return false
end

function modifier_jakiro_macropyre_lua_thinker:IsDebuff()
	return false
end

function modifier_jakiro_macropyre_lua_thinker:IsStunDebuff()
	return false
end

function modifier_jakiro_macropyre_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_jakiro_macropyre_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "path_radius" )
	self.duration = self:GetAbility():GetSpecialValueFor( "linger_duration" )
	self.interval = self:GetAbility():GetSpecialValueFor( "burn_interval" )
	self.range = self:GetAbility():GetCastRange( self.parent:GetAbsOrigin(), nil ) + self.caster:GetCastRangeBonus()
	if self:GetCaster():HasScepter() then
		self.damage = self:GetAbility():GetSpecialValueFor( "damage_scepter" )
	else
		self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	end

	if not IsServer() then return end

	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- calculate stuff
	local start_range = 234
	self.direction = Vector( kv.x, kv.y, 0 )
	self.startpoint = self.parent:GetOrigin() + self.direction * start_range
	self.endpoint = self.startpoint + self.direction * self.range

	-- destroy trees along line
	local step = 0
	while step < self.range do
		local loc = self.startpoint + self.direction * step
		GridNav:DestroyTreesAroundPoint( loc, self.radius, true )

		step = step + self.radius
	end

	-- Start interval
	self:StartIntervalThink( self.interval )

	-- play effects
	self:PlayEffects()
end

function modifier_jakiro_macropyre_lua_thinker:OnRefresh( kv )
	
end

function modifier_jakiro_macropyre_lua_thinker:OnRemoved()
end

function modifier_jakiro_macropyre_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_jakiro_macropyre_lua_thinker:OnIntervalThink()
	-- continuously find units in line
	local enemies = FindUnitsInLine(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.startpoint,	-- point, center point
		self.endpoint,
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		self.abilityTargetTeam,	-- int, team filter
		self.abilityTargetType,	-- int, type filter
		self.abilityTargetFlags	-- int, flag filter
	)

	for _,enemy in pairs(enemies) do
		-- add modifier
		enemy:AddNewModifier(
			self.caster, -- player source
			self:GetAbility(), -- ability source
			"modifier_jakiro_macropyre_lua", -- modifier name
			{
				duration = self.duration,
				interval = self.interval,
				damage = self.damage * self.interval,
				damage_type = self.abilityDamageType,
			} -- kv
		)
	end

end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_jakiro_macropyre_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf"
	local sound_cast = "hero_jakiro.macropyre"
	if self.caster:HasScepter() then
		sound_cast = "hero_jakiro.macropyre.scepter"
	end

	-- Get Data
	local duration = self:GetDuration()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.startpoint )
	ParticleManager:SetParticleControl( effect_cast, 1, self.endpoint )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( duration, 0, 0 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

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