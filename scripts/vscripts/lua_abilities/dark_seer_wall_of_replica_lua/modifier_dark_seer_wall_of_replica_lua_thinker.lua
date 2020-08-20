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
modifier_dark_seer_wall_of_replica_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_seer_wall_of_replica_lua_thinker:IsHidden()
	return false
end

function modifier_dark_seer_wall_of_replica_lua_thinker:IsDebuff()
	return false
end

function modifier_dark_seer_wall_of_replica_lua_thinker:IsStunDebuff()
	return false
end

function modifier_dark_seer_wall_of_replica_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_seer_wall_of_replica_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.team = self.caster:GetTeamNumber()

	-- references
	self.outgoing = self:GetAbility():GetSpecialValueFor( "replica_damage_outgoing" )
	self.incoming = self:GetAbility():GetSpecialValueFor( "replica_damage_incoming" )
	self.duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )

	local length = self:GetAbility():GetSpecialValueFor( "width" )
	if self.caster:HasScepter() then
		length = length * self:GetAbility():GetSpecialValueFor( "scepter_length_multiplier" )
	end

	if not IsServer() then return end

	-- get data
	local direction = Vector( kv.x, kv.y, 0 ):Normalized()
	self.origin = self:GetParent():GetOrigin() + direction*length/2
	self.target = self:GetParent():GetOrigin() - direction*length/2

	-- init
	self.width = 50
	self.bounty = 5
	local tick = 0.1
	self.illusions = {}

	-- Start interval
	self:StartIntervalThink( tick )
	self:OnIntervalThink()

	-- Play effects
	self:PlayEffects()
end

function modifier_dark_seer_wall_of_replica_lua_thinker:OnRefresh( kv )
	
end

function modifier_dark_seer_wall_of_replica_lua_thinker:OnRemoved()
end

function modifier_dark_seer_wall_of_replica_lua_thinker:OnDestroy()
	if not IsServer() then return end

	-- stop effects
	local sound_loop = "Hero_Dark_Seer.Wall_of_Replica_lp"
	StopSoundOn( sound_loop, self:GetParent() )

	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_seer_wall_of_replica_lua_thinker:OnIntervalThink()
	-- find line
	local enemies = FindUnitsInLine(
		self.team,	-- int, your team number
		self.origin,	-- point, center point
		self.target,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.width,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS	-- int, flag filter
	)

	for _,enemy in pairs(enemies) do
		-- slow
		if (not enemy:IsMagicImmune()) and (not enemy:IsInvulnerable()) then
			enemy:AddNewModifier(
				self.caster, -- player source
				self.ability, -- ability source
				"modifier_dark_seer_wall_of_replica_lua_debuff", -- modifier name
				{ duration = self.duration } -- kv
			)
		end

		-- illusion
		local id = enemy:GetPlayerOwnerID()
		if (not self.illusions[id]) or (not self.illusions[id]:IsAlive()) then

			-- create new illusion
			local illu = CreateIllusions(
				self.caster,
				enemy,
				{
					outgoing_damage = self.outgoing,
					incoming_damage = self.incoming,
					bounty_base = self.bounty,
					duration = self:GetRemainingTime(),
				},
				1,
				64,
				false,
				true
			)
			illu = illu[1]
			illu:AddNewModifier(
				self.caster, -- player source
				self.ability, -- ability source
				"modifier_dark_seer_wall_of_replica_lua_illusion", -- modifier name
				{} -- kv
			)

			self.illusions[id] = illu
		end
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_seer_wall_of_replica_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica.vpcf"
	local sound_cast = "Hero_Dark_Seer.Wall_of_Replica_Start"
	local sound_loop = "Hero_Dark_Seer.Wall_of_Replica_lp"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( effect_cast, 1, self.target )
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
	EmitSoundOn( sound_cast, self:GetParent() )
	EmitSoundOn( sound_loop, self:GetParent() )
end