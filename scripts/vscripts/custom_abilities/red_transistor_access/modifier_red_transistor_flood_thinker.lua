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
	self.interval = kv.interval

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()

	self:PlayEffects()
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
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_red_transistor_flood_damage", -- modifier name
			{
				duration = self.interval + 0.05,
				dps = self.dps,
				interval = self.interval,
			} -- kv
		)
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_red_transistor_flood_thinker:IsAura()
	return false
end

function modifier_red_transistor_flood_thinker:GetModifierAura()
	return "modifier_red_transistor_flood_damage"
end

function modifier_red_transistor_flood_thinker:GetAuraRadius()
	return self.radius
end

function modifier_red_transistor_flood_thinker:GetAuraDuration()
	return 0.1
end

function modifier_red_transistor_flood_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_red_transistor_flood_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_red_transistor_flood_thinker:GetAuraSearchFlags()
	return 0
end

function modifier_red_transistor_flood_thinker:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_red_transistor_flood_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/econ/items/rubick/rubick_arcana/rubick_arc_ambient_lines_projected.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 60, Vector( 55, 230, 190 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end