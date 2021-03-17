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
modifier_red_transistor_flood_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_flood_thinker:IsHidden()
	return false
end

function modifier_red_transistor_flood_thinker:IsDebuff()
	return false
end

function modifier_red_transistor_flood_thinker:IsStunDebuff()
	return false
end

function modifier_red_transistor_flood_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_flood_thinker:OnCreated( kv )
	-- references

	if not IsServer() then return end
	self.dps = kv.dps
	self.radius = kv.radius
	self.interval = 0.1

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self.dps*self.interval,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_red_transistor_flood_thinker:OnRefresh( kv )
	
end

function modifier_red_transistor_flood_thinker:OnRemoved()
end

function modifier_red_transistor_flood_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_red_transistor_flood_thinker:OnIntervalThink()
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
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end
end

-- --------------------------------------------------------------------------------
-- -- Aura Effects
-- function modifier_red_transistor_flood_thinker:IsAura()
-- 	return true
-- end

-- function modifier_red_transistor_flood_thinker:GetModifierAura()
-- 	return "modifier_red_transistor_flood_thinker_effect"
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraRadius()
-- 	return self.radius
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraDuration()
-- 	return self.radius
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraSearchTeam()
-- 	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraSearchType()
-- 	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraSearchFlags()
-- 	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
-- end

-- function modifier_red_transistor_flood_thinker:GetAuraEntityReject( hEntity )
-- 	if IsServer() then
		
-- 	end

-- 	return false
-- end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_flood_thinker:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_flood_thinker:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_flood_thinker:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_flood_thinker:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_flood_thinker:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_POINT_FOLLOW,
-- 		"attach_hitloc",
-- 		Vector(0,0,0), -- unknown
-- 		true -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end