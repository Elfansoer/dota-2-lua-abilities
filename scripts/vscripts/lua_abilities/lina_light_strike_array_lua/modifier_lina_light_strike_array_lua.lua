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
modifier_lina_light_strike_array_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lina_light_strike_array_lua:IsHidden()
	return true
end

function modifier_lina_light_strike_array_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lina_light_strike_array_lua:OnCreated( kv )
	-- references
	self.stun = self:GetAbility():GetSpecialValueFor( "light_strike_array_stun_duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "light_strike_array_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "light_strike_array_aoe" )

	if not IsServer() then return end
	-- play effects
	self:PlayEffects1()
end

function modifier_lina_light_strike_array_lua:OnRefresh( kv )
	
end

function modifier_lina_light_strike_array_lua:OnRemoved()
end

function modifier_lina_light_strike_array_lua:OnDestroy()
	if not IsServer() then return end
	-- destroy trees
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.radius, false )

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- find enemies
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

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- stun
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = self.stun } -- kv
		)
	end

	-- play effects
	self:PlayEffects2()

	-- remove thinker
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lina_light_strike_array_lua:PlayEffects1()
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

function modifier_lina_light_strike_array_lua:PlayEffects2()
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