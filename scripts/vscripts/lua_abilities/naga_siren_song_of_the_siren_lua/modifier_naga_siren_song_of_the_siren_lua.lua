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
modifier_naga_siren_song_of_the_siren_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_song_of_the_siren_lua:IsHidden()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua:IsDebuff()
	return false
end

function modifier_naga_siren_song_of_the_siren_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_song_of_the_siren_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	local caster = self:GetCaster()

	-- create scepter modifier
	if caster:HasScepter() then
		self.scepter = caster:AddNewModifier(
			caster, -- player source
			self:GetAbility(), -- ability source
			"modifier_naga_siren_song_of_the_siren_lua_scepter", -- modifier name
			{} -- kv
		)
	end

	-- play effects
	self:PlayEffects()
end

function modifier_naga_siren_song_of_the_siren_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )	
end

function modifier_naga_siren_song_of_the_siren_lua:OnRemoved()
end

function modifier_naga_siren_song_of_the_siren_lua:OnDestroy()
	if not IsServer() then return end

	-- destroy scepter modifier
	if self.scepter and not self.scepter:IsNull() then
		self.scepter:Destroy()
	end

	-- switch ability layout
	local ability = self:GetCaster():FindAbilityByName( "naga_siren_song_of_the_siren_end_lua" )
	if not ability then return end

	self:GetCaster():SwapAbilities(
		self:GetAbility():GetAbilityName(),
		ability:GetAbilityName(),
		true,
		false
	)
end

--------------------------------------------------------------------------------
-- Helper
function modifier_naga_siren_song_of_the_siren_lua:End()
	-- play effects
	local sound_cast = "Hero_NagaSiren.SongOfTheSiren"
	local sound_stop = "Hero_NagaSiren.SongOfTheSiren.Cancel"
	StopSoundOn( sound_cast, self:GetCaster() )
	EmitSoundOn( sound_stop, self:GetCaster() )

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_naga_siren_song_of_the_siren_lua:IsAura()
	return true
end

function modifier_naga_siren_song_of_the_siren_lua:GetModifierAura()
	return "modifier_naga_siren_song_of_the_siren_lua_debuff"
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraRadius()
	return self.radius
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraDuration()
	return 0.4
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_naga_siren_song_of_the_siren_lua:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_naga_siren_song_of_the_siren_lua:PlayEffects()
	-- Get Resources
	local particle_cast1 = "particles/units/heroes/hero_siren/naga_siren_siren_song_cast.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_siren/naga_siren_song_aura.vpcf"
	local sound_cast = "Hero_NagaSiren.SongOfTheSiren"

	-- Get Data
	local caster = self:GetCaster()

	-- Create Particle 1
	local effect_cast = ParticleManager:CreateParticle( particle_cast1, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- create particle 2
	effect_cast = ParticleManager:CreateParticle( particle_cast2, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		caster,
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

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end