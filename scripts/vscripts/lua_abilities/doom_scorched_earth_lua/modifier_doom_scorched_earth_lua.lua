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
modifier_doom_scorched_earth_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_doom_scorched_earth_lua:IsHidden()
	return false
end

function modifier_doom_scorched_earth_lua:IsDebuff()
	return false
end

function modifier_doom_scorched_earth_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_doom_scorched_earth_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )

	if not IsServer() then return end
	local interval = 1
	self.owner = kv.isProvidedByAura~=1

	if not self.owner then return end
	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}

	-- Start interval
	self:StartIntervalThink( interval )

	-- Play effects
	self:PlayEffects1()
end

function modifier_doom_scorched_earth_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )	

	if not IsServer() then return end
	if not self.owner then return end
	-- update damage
	self.damageTable.damage = damage
end

function modifier_doom_scorched_earth_lua:OnRemoved()
end

function modifier_doom_scorched_earth_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_doom_scorched_earth_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}

	return funcs
end

function modifier_doom_scorched_earth_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_doom_scorched_earth_lua:OnIntervalThink()
	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
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
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- play effects
		self:PlayEffects2( enemy )
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_doom_scorched_earth_lua:IsAura()
	return self.owner
end

function modifier_doom_scorched_earth_lua:GetModifierAura()
	return "modifier_doom_scorched_earth_lua"
end

function modifier_doom_scorched_earth_lua:GetAuraRadius()
	return self.radius
end

function modifier_doom_scorched_earth_lua:GetAuraDuration()
	return 0.5
end

function modifier_doom_scorched_earth_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_doom_scorched_earth_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_doom_scorched_earth_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_doom_scorched_earth_lua:GetAuraEntityReject( hEntity )
	if not IsServer() then return end

	if hEntity==self:GetParent() then return true end

	return hEntity:GetPlayerOwnerID()~=self:GetParent():GetPlayerOwnerID()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_doom_scorched_earth_lua:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_buff.vpcf"
end

function modifier_doom_scorched_earth_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_doom_scorched_earth_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_scorched_earth.vpcf"
	local sound_cast = "Hero_DoomBringer.ScorchedEarthAura"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )

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

function modifier_doom_scorched_earth_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_debuff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end