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
modifier_void_spirit_resonant_pulse_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_void_spirit_resonant_pulse_lua:IsHidden()
	return false
end

function modifier_void_spirit_resonant_pulse_lua:IsDebuff()
	return false
end

function modifier_void_spirit_resonant_pulse_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_void_spirit_resonant_pulse_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
	self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
	self.return_speed = self:GetAbility():GetSpecialValueFor( "return_projectile_speed" )

	if not IsServer() then return end

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- set up shield
	self.shield = self.base_absorb
	self.max_shield = self.shield

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- precache projectile
	self.info = {
		Target = self:GetParent(),
		-- Source = caster,
		Ability = self:GetAbility(),	
		EffectName = "",
		iMoveSpeed = self.return_speed,
		bDodgeable = false,                           -- Optional
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
	}

	-- Create pulse
	local pulse = self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			end_radius = self.radius,
			speed = self.speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		} -- kv
	)
	pulse:SetCallback( function( enemy )
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		-- Play effects
		self:PlayEffects3( enemy )

		if not enemy:IsHero() then return end

		-- create projectile
		self.info.Source = enemy
		ProjectileManager:CreateTrackingProjectile(self.info)

		-- Play effects
		self:PlayEffects4( enemy )
	end)

	-- Play effects
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_void_spirit_resonant_pulse_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.base_absorb = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
	self.hero_absorb = self:GetAbility():GetSpecialValueFor( "absorb_per_hero_hit" )
	self.return_speed = self:GetAbility():GetSpecialValueFor( "return_speed" )

	if not IsServer() then return end

	-- set up shield
	self.shield = self.shield + self.base_absorb
	self.max_shield = math.max( self.shield, self.max_shield )

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- Create pulse
	local pulse = self:GetParent():AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			end_radius = self.radius,
			speed = self.speed,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		} -- kv
	)
	pulse:SetCallback( function( enemy )
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		-- Play effects
		self:PlayEffects3( enemy )

		if not enemy:IsHero() then return end

		-- create projectile
		self.info.Source = enemy
		ProjectileManager:CreateTrackingProjectile(self.info)

		-- Play effects
		self:PlayEffects4( enemy )
	end)

	-- Play effects
	self:PlayEffects1()
end

function modifier_void_spirit_resonant_pulse_lua:OnRemoved()
end

function modifier_void_spirit_resonant_pulse_lua:OnDestroy()
	if not IsServer() then return end
	local sound_destroy = "Hero_VoidSpirit.Pulse.Destroy"
	EmitSoundOn( sound_destroy, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_void_spirit_resonant_pulse_lua:AddCustomTransmitterData()
	-- on server
	local data = {
        max_shield = self.max_shield,
        shield = self.shield,
	}

	return data
end

function modifier_void_spirit_resonant_pulse_lua:HandleCustomTransmitterData( data )
	-- on client
    self.max_shield = data.max_shield
    self.shield = data.shield
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_void_spirit_resonant_pulse_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
	}

	return funcs
end

function modifier_void_spirit_resonant_pulse_lua:GetModifierIncomingPhysicalDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.shield
		end
	end

	-- play effects
	self:PlayEffects5()

	-- block based on damage
	if params.damage>self.shield then
		self:Destroy()
		return -self.shield
	else
		self.shield = self.shield-params.damage

		-- refresh shield on client using transmitter data
		self:SendBuffRefreshToClients()

		return -params.damage
	end
end

--------------------------------------------------------------------------------
-- Helper
function modifier_void_spirit_resonant_pulse_lua:Absorb()
	self.shield = self.shield + self.hero_absorb
	self.max_shield = math.max( self.shield, self.max_shield )

	-- refresh shield on client using transmitter data
	self:SendBuffRefreshToClients()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_void_spirit_resonant_pulse_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_void_spirit_resonant_pulse_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_void_spirit_resonant_pulse_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf"
	local sound_cast = "Hero_VoidSpirit.Pulse"

	-- adjustment
	local radius = self.radius * 2

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_void_spirit_resonant_pulse_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf"
	local sound_cast = "Hero_VoidSpirit.Pulse.Cast"

	-- Get Data
	local radius = 100

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	local effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end


function modifier_void_spirit_resonant_pulse_lua:PlayEffects3( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf"
	local sound_cast = "Hero_VoidSpirit.Pulse.Target"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
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
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end

function modifier_void_spirit_resonant_pulse_lua:PlayEffects4( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_void_spirit_resonant_pulse_lua:PlayEffects5()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf"

	-- Get Data
	local radius = 100

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end