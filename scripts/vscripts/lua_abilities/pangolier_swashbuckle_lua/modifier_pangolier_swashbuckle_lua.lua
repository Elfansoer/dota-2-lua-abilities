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
modifier_pangolier_swashbuckle_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pangolier_swashbuckle_lua:IsHidden()
	return true
end

function modifier_pangolier_swashbuckle_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pangolier_swashbuckle_lua:OnCreated( kv )
	-- references
	self.range = self:GetAbility():GetSpecialValueFor( "range" )
	self.speed = self:GetAbility():GetSpecialValueFor( "dash_speed" )
	self.radius = self:GetAbility():GetSpecialValueFor( "start_radius" )

	self.interval = self:GetAbility():GetSpecialValueFor( "attack_interval" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.strikes = self:GetAbility():GetSpecialValueFor( "strikes" )

	if not IsServer() then return end
	-- get positions
	self.origin = self:GetParent():GetOrigin()
	self.direction = Vector( kv.dir_x, kv.dir_y, 0 )
	self.target = self.origin + self.direction*self.range

	-- set count
	self.count = 0

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_pangolier_swashbuckle_lua:OnRefresh( kv )
end

function modifier_pangolier_swashbuckle_lua:OnRemoved()
end

function modifier_pangolier_swashbuckle_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pangolier_swashbuckle_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
	}

	return funcs
end

function modifier_pangolier_swashbuckle_lua:GetModifierOverrideAttackDamage()
	return self.damage
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_pangolier_swashbuckle_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_pangolier_swashbuckle_lua:OnIntervalThink()
	-- find units in line
	local enemies = FindUnitsInLine(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self.origin,	-- point, center point
		self.target,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0	-- int, flag filter
	)

	for _,enemy in pairs(enemies) do
		-- Attack
		self:GetParent():PerformAttack( enemy, true, true, true, false, false, false, true )

		-- play sound
		local sound_target = "Hero_Pangolier.Swashbuckle.Damage"
		EmitSoundOn( sound_target, enemy )
	end

	-- Play effects
	self:PlayEffects()

	self.count = self.count+1
	if self.count>=self.strikes then
		self:Destroy()
	end
end

function modifier_pangolier_swashbuckle_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf"
	local sound_cast = "Hero_Pangolier.Swashbuckle.Attack"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, self.direction )

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