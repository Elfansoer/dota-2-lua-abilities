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
modifier_enigma_black_hole_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_enigma_black_hole_lua_thinker:IsHidden()
	return false
end

function modifier_enigma_black_hole_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_enigma_black_hole_lua_thinker:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "far_radius" )
	self.interval = 1
	self.ticks = math.floor(self:GetDuration()/self.interval+0.5) -- round
	self.tick = 0

	if IsServer() then
		-- precache damage
		local damage = self:GetAbility():GetSpecialValueFor( "near_damage" )
		self.damageTable = {
			-- victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			ability = self:GetAbility(), --Optional.
			-- damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( self.interval )
		self:PlayEffects()
	end
end

function modifier_enigma_black_hole_lua_thinker:OnRefresh( kv )
	
end

function modifier_enigma_black_hole_lua_thinker:OnRemoved()
	if IsServer() then
		-- ensure last tick damage happens
		if self:GetRemainingTime()<0.01 and self.tick<self.ticks then
			self:OnIntervalThink()
		end

		UTIL_Remove( self:GetParent() )
	end

	local sound_cast = "Hero_Enigma.Black_Hole"
	local sound_stop = "Hero_Enigma.Black_Hole.Stop"
	StopSoundOn( sound_cast, self:GetParent() )
	EmitSoundOn( sound_stop, self:GetParent() )
end

function modifier_enigma_black_hole_lua_thinker:OnDestroy()
	if IsServer() then
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_enigma_black_hole_lua_thinker:OnIntervalThink()
	-- aoe damage
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end

	-- tick
	self.tick = self.tick+1
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_enigma_black_hole_lua_thinker:IsAura()
	return true
end

function modifier_enigma_black_hole_lua_thinker:GetModifierAura()
	return "modifier_enigma_black_hole_lua_debuff"
end

function modifier_enigma_black_hole_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_enigma_black_hole_lua_thinker:GetAuraDuration()
	return 0.1
end

function modifier_enigma_black_hole_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_enigma_black_hole_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_enigma_black_hole_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_enigma_black_hole_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_enigma/enigma_blackhole.vpcf"
	local sound_cast = "Hero_Enigma.Black_Hole"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )

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
end