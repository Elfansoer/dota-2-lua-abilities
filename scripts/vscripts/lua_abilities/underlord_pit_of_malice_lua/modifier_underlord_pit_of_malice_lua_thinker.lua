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
modifier_underlord_pit_of_malice_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_pit_of_malice_lua_thinker:IsHidden()
	return false
end

function modifier_underlord_pit_of_malice_lua_thinker:IsDebuff()
	return false
end

function modifier_underlord_pit_of_malice_lua_thinker:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_pit_of_malice_lua_thinker:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.pit_damage = self:GetAbility():GetSpecialValueFor( "pit_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "ensnare_duration" )

	if not IsServer() then return end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- start interval
	self:StartIntervalThink( 0.033 )
	self:OnIntervalThink()

	-- play effects
	self:PlayEffects()

end

function modifier_underlord_pit_of_malice_lua_thinker:OnRefresh( kv )
	
end

function modifier_underlord_pit_of_malice_lua_thinker:OnRemoved()

end

function modifier_underlord_pit_of_malice_lua_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_underlord_pit_of_malice_lua_thinker:OnIntervalThink()
	-- Using aura's sticky duration doesn't allow it to be purged, so here we are

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
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
		-- check if not cooldown
		local modifier = enemy:FindModifierByNameAndCaster( "modifier_underlord_pit_of_malice_lua_cooldown", self:GetCaster() )
		if not modifier then
			-- apply modifier
			enemy:AddNewModifier(
				self.caster, -- player source
				self:GetAbility(), -- ability source
				"modifier_underlord_pit_of_malice_lua", -- modifier name
				{ duration = self.duration } -- kv
			)
		end
	end
end

-- --------------------------------------------------------------------------------
-- -- Aura Effects
-- function modifier_underlord_pit_of_malice_lua_thinker:IsAura()
-- 	return true
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetModifierAura()
-- 	return "modifier_underlord_pit_of_malice_lua"
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraRadius()
-- 	return self.radius
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraDuration()
-- 	return self.duration
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraSearchTeam()
-- 	return DOTA_UNIT_TARGET_TEAM_ENEMY
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraSearchType()
-- 	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraSearchFlags()
-- 	return 0
-- end

-- function modifier_underlord_pit_of_malice_lua_thinker:GetAuraEntityReject( hEntity )
-- 	if not IsServer() then return false end

-- 	-- reject if cooldown
-- 	if hEntity:FindModifierByNameAndCaster( "modifier_underlord_pit_of_malice_lua_cooldown", self:GetCaster() ) then
-- 		return true
-- 	end

-- 	return false
-- end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_underlord_pit_of_malice_lua_thinker:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice"

	-- Get Data
	local parent = self:GetParent()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent )
	ParticleManager:SetParticleControl( effect_cast, 0, parent:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self:GetDuration(), 0, 0 ) )

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
	EmitSoundOn( sound_cast, parent )
end