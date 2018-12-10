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
modifier_skywrath_mage_mystic_flare_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_skywrath_mage_mystic_flare_lua_thinker:OnCreated( kv )
	-- references
	local interval = self:GetAbility():GetSpecialValueFor( "damage_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if IsServer() then
		-- precache damage
		self.damage = self.damage*interval/kv.duration
		self.damageTable = {
			-- victim = target,
			attacker = self:GetCaster(),
			-- damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self:GetAbility(), --Optional.
			-- damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		}

		-- Start interval
		self:StartIntervalThink( interval )
		self:OnIntervalThink()

		-- play effects
		self:PlayEffects( self.radius, kv.duration, interval )
	end
end

function modifier_skywrath_mage_mystic_flare_lua_thinker:OnRemoved()
end

function modifier_skywrath_mage_mystic_flare_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_skywrath_mage_mystic_flare_lua_thinker:OnIntervalThink()
	-- find heroes
	local heroes = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	if #heroes<1 then return end
	for _,hero in pairs(heroes) do
		self.damageTable.victim = hero
		self.damageTable.damage = self.damage/#heroes
		ApplyDamage( self.damageTable )
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_skywrath_mage_mystic_flare_lua_thinker:PlayEffects( radius, duration, interval )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_mystic_flare_ambient.vpcf"
	local sound_cast = "Hero_SkywrathMage.MysticFlare"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, duration, interval ) )
	assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_color"))(self,effect_cast)
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end