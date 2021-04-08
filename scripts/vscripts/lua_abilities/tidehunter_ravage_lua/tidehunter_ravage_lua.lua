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
tidehunter_ravage_lua = class({})
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_ring_lua", "lua_abilities/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function tidehunter_ravage_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf", context )
end

function tidehunter_ravage_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Start
function tidehunter_ravage_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local damage = self:GetAbilityDamage()
	local damage_type = self:GetAbilityDamageType()
	local radius = self:GetSpecialValueFor( "radius" )
	local speed = self:GetSpecialValueFor( "speed" )
	local duration = self:GetSpecialValueFor( "duration" )
	local width = 250
	local height = 350
	local knock_duration = 0.5

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = caster,
		damage = damage,
		damage_type = damage_type,
		ability = self, --Optional.
	}

	local thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_generic_ring_lua", -- modifier name
		{
			start_radius = width,
			end_radius = radius,
			speed = speed,
			width = width,
			target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	ring = thinker:FindModifierByName( "modifier_generic_ring_lua" )

	ring:SetCallback( function( enemy )
		-- knock upwards
		local knockback = enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_generic_arc_lua", -- modifier name
			{
				duration = knock_duration,
				height = height,
			} -- kv
		)
		knockback:SetEndCallback( function()
			-- damage
			damageTable.victim = enemy
			ApplyDamage( damageTable )

			-- play effects
			local sound_target = "Hero_Tidehunter.RavageDamage"
			EmitSoundOn( sound_target, enemy )
		end)

		-- stun
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = duration } -- kv
		)

		-- play effects
		self:PlayEffects2( enemy )
	end)

	-- play effects
	self:PlayEffects1( caster:GetOrigin(), radius, speed )
end
--------------------------------------------------------------------------------
-- Effects
function tidehunter_ravage_lua:PlayEffects1( center, radius, speed )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf"
	local sound_cast = "Ability.Ravage"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, center )
	for i=1,5 do
		-- local pos = actual_radius/5*i
		local pos = radius/5*i
		ParticleManager:SetParticleControl( effect_cast, i, Vector( pos, 1, 1 ) )
	end
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( center, sound_cast, self:GetCaster() )
end

function tidehunter_ravage_lua:PlayEffects2( enemy )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, enemy )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end