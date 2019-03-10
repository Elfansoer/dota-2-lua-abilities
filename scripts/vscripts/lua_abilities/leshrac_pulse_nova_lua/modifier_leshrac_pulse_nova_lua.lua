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
modifier_leshrac_pulse_nova_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_leshrac_pulse_nova_lua:IsHidden()
	return false
end

function modifier_leshrac_pulse_nova_lua:IsDebuff()
	return false
end

function modifier_leshrac_pulse_nova_lua:IsPurgable()
	return false
end

function modifier_leshrac_pulse_nova_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT 
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_leshrac_pulse_nova_lua:OnCreated( kv )
	if not IsServer() then return end
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.manacost = self:GetAbility():GetSpecialValueFor( "mana_cost_per_second" )
	local interval = 1

	-- precache
	self.parent = self:GetParent()
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:Burn()
	self:StartIntervalThink( interval )

	-- play effects
	local sound_loop = "Hero_Leshrac.Pulse_Nova"
	EmitSoundOn( sound_loop, self.parent )
end

function modifier_leshrac_pulse_nova_lua:OnRefresh( kv )
end

function modifier_leshrac_pulse_nova_lua:OnRemoved()
end

function modifier_leshrac_pulse_nova_lua:OnDestroy()
	if not IsServer() then return end
	local sound_loop = "Hero_Leshrac.Pulse_Nova"
	StopSoundOn( sound_loop, self.parent )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_leshrac_pulse_nova_lua:OnIntervalThink()
	-- check mana
	local mana = self.parent:GetMana()
	if mana < self.manacost then
		-- turn off
		if self:GetAbility():GetToggleState() then
			self:GetAbility():ToggleAbility()
		end
		return
	end

	-- damage
	self:Burn()
end

function modifier_leshrac_pulse_nova_lua:Burn()
	-- spend mana
	self.parent:SpendMana( self.manacost, self:GetAbility() )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
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

		-- play effects
		self:PlayEffects( enemy )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_leshrac_pulse_nova_lua:GetEffectName()
	return "particles/units/heroes/hero_leshrac/leshrac_pulse_nova_ambient.vpcf"
end

function modifier_leshrac_pulse_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_leshrac_pulse_nova_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_leshrac/leshrac_pulse_nova.vpcf"
	local sound_cast = "Hero_Leshrac.Pulse_Nova_Strike"

	-- radius
	local radius = 100

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
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius,0,0) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- -- buff particle
	-- self:AddParticle(
	-- 	effect_cast,
	-- 	false, -- bDestroyImmediately
	-- 	false, -- bStatusEffect
	-- 	-1, -- iPriority
	-- 	false, -- bHeroEffect
	-- 	false -- bOverheadEffect
	-- )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end