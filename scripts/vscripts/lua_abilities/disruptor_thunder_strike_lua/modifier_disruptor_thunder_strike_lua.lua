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
modifier_disruptor_thunder_strike_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_disruptor_thunder_strike_lua:IsHidden()
	return false
end

function modifier_disruptor_thunder_strike_lua:IsDebuff()
	return true
end

function modifier_disruptor_thunder_strike_lua:IsStunDebuff()
	return false
end

function modifier_disruptor_thunder_strike_lua:IsPurgable()
	return true
end

function modifier_disruptor_thunder_strike_lua:RemoveOnDeath()
	return false
end

function modifier_disruptor_thunder_strike_lua:DestroyOnExpire()
	return false
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_disruptor_thunder_strike_lua:OnCreated( kv )
	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "strikes" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	local interval = self:GetAbility():GetSpecialValueFor( "strike_interval" )
	local damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )

	if IsServer() then
		-- precache damage
		self.damageTable = {
			-- victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}

		-- add duration info
		local duration = (self.count-1) * interval
		self:SetDuration( duration, true )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()

		-- play effects
		self.sound_loop = "Hero_Disruptor.ThunderStrike.Thunderator"
		EmitSoundOn( self.sound_loop, self:GetParent() )
	end
end

function modifier_disruptor_thunder_strike_lua:OnRefresh( kv )
	local damage = self:GetAbility():GetSpecialValueFor( "strike_damage" )
	self.count = self:GetAbility():GetSpecialValueFor( "strikes" )
	local interval = self:GetAbility():GetSpecialValueFor( "strike_interval" )

	if IsServer() then
		self.damageTable.damage = damage

		-- add duration info
		local duration = (self.count-1) * interval
		self:SetDuration( duration, true )

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()
	end
end

function modifier_disruptor_thunder_strike_lua:OnRemoved()
end

function modifier_disruptor_thunder_strike_lua:OnDestroy()
	if not IsServer() then return end
	-- add fow
	AddFOWViewer( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), self.radius + 200, 4, false )

	-- stop sound
	StopSoundOn( self.sound_loop, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_disruptor_thunder_strike_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
	}

	return funcs
end

function modifier_disruptor_thunder_strike_lua:GetModifierProvidesFOWVision()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_disruptor_thunder_strike_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_disruptor_thunder_strike_lua:OnIntervalThink()
	-- find units in radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- for every unit
	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end

	-- play effects
	self:PlayEffects()

	-- calculate counter
	self.count = self.count-1
	if self.count<1 then
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_disruptor_thunder_strike_lua:GetEffectName()
	return "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_buff.vpcf"
end

function modifier_disruptor_thunder_strike_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_disruptor_thunder_strike_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf"
	local sound_cast = "Hero_Disruptor.ThunderStrike.Target"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 2, self:GetParent():GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
	-- EmitSoundOn( sound_cast, self:GetParent() )
end