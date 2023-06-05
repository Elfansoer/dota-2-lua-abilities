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
modifier_abaddon_aphotic_shield_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_abaddon_aphotic_shield_lua:IsHidden()
	return false
end

function modifier_abaddon_aphotic_shield_lua:IsDebuff()
	return false
end

function modifier_abaddon_aphotic_shield_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_abaddon_aphotic_shield_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- references
	self.barrier = self:GetAbility():GetSpecialValueFor( "damage_absorb" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end

	self.current_shield = self.barrier

	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		damage = self.barrier,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- Play effects
	self:PlayEffects()
end

function modifier_abaddon_aphotic_shield_lua:OnRefresh( kv )
end

function modifier_abaddon_aphotic_shield_lua:OnRemoved()
end

function modifier_abaddon_aphotic_shield_lua:OnDestroy()
	if not IsServer() then return end

	-- find units in radius
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
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end

	-- Play effects
	StopSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Destroy", self.parent)
end

--------------------------------------------------------------------------------
-- Transmitter data
function modifier_abaddon_aphotic_shield_lua:AddCustomTransmitterData()
	-- on server
	local data = {
		current_shield = self.current_shield
	}

	return data
end

function modifier_abaddon_aphotic_shield_lua:HandleCustomTransmitterData( data )
	-- on client
	self.current_shield = data.current_shield
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_abaddon_aphotic_shield_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}

	return funcs
end

function modifier_abaddon_aphotic_shield_lua:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		return self.current_shield
	end

	-- play effects
	self:PlayEffects2()

	-- block based on damage
	if params.damage>self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage

		-- refresh shield on client using transmitter data
		self:SendBuffRefreshToClients()

		return -params.damage
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_abaddon_aphotic_shield_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )

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
	EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
end


function modifier_abaddon_aphotic_shield_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end