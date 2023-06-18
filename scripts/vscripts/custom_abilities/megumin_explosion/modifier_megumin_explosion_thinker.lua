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
modifier_megumin_explosion_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_megumin_explosion_thinker:IsHidden()
	return false
end

function modifier_megumin_explosion_thinker:IsDebuff()
	return false
end

function modifier_megumin_explosion_thinker:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_megumin_explosion_thinker:OnCreated( kv )
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "red_damage_tooltip" )
	self.stun = self:GetAbility():GetSpecialValueFor( "green_stun_tooltip" )
	self.radius = self:GetAbility():GetSpecialValueFor( "yellow_radius" )
	self.creep_mult = self:GetAbility():GetSpecialValueFor( "creep_multiplier" )
	self.ally_pct = self:GetAbility():GetSpecialValueFor( "ally_damage" )

	if not IsServer() then return end
	-- send init data from server to client
	self:SetHasCustomTransmitterData( true )

	-- precache damage
	self.damageTable = {
		-- victim = target,
		-- damage = self.damage,
		attacker = self.caster,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- play effects
	self:PlayEffects1()
	self:PlayEffects()
end

function modifier_megumin_explosion_thinker:OnRefresh( kv )
end

function modifier_megumin_explosion_thinker:OnRemoved()
end

function modifier_megumin_explosion_thinker:OnDestroy()
	if not IsServer() then return end
	-- destroy trees
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )

	-- find enemies
	local units = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,unit in pairs(units) do
		-- damage
		self.damageTable.victim = unit
		self.damageTable.damage_flags = DOTA_DAMAGE_FLAG_NONE
		local damage = self.damage

		if unit:GetTeamNumber()==self.parent:GetTeamNumber() then
			self.damageTable.damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL
			damage = damage * self.ally_pct/100
		end
		if unit:IsCreep() and (not unit:IsCreepHero()) then
			damage = damage * self.creep_mult
		end

		self.damageTable.damage = damage

		ApplyDamage( self.damageTable )

		if self.stun > 0 then
			-- stun
			unit:AddNewModifier(
				self.caster,
				self.ability,
				"modifier_stunned",
				{duration = self.stun}
			)
		end
	end

	-- play effects
	self:PlayEffects2()

	-- remove thinker
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_megumin_explosion_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lina/lina_spell_light_strike_array_ray_team.vpcf"
	local sound_cast = "Ability.PreLightStrikeArray"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForTeam( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end

function modifier_megumin_explosion_thinker:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf"
	local sound_cast = "Ability.LightStrikeArray"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), sound_cast, self:GetCaster() )
end

function modifier_megumin_explosion_thinker:PlayEffects()
	self:PlayEffectsRing( Vector(255,0,0), 207, 60, 0 )
	self:PlayEffectsRing( Vector(0,255,0), 209, 40, 15 )
	self:PlayEffectsRing( Vector(0,0,255), 211, 20, 30 )
	self:PlayEffectsRing( Vector(255,215,0), 213, 0, 45 )
end

function modifier_megumin_explosion_thinker:PlayEffectsRing( color, shape, radius, height )
	local particle_cast = "particles/units/heroes/hero_megumin/epitrochoid.vpcf"
	local base_radius = 80
	local base_ring_size = 7

	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.caster )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( shape, 0, height ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( base_radius + radius, 0, base_ring_size ) )
	ParticleManager:SetParticleControl( effect_cast, 60, color )
	ParticleManager:SetParticleControl( effect_cast, 61, Vector( 1, 0, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	return effect_cast
end
