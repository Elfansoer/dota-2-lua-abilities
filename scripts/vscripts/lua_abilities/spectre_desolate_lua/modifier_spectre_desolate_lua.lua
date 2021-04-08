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
modifier_spectre_desolate_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spectre_desolate_lua:IsHidden()
	return true
end

function modifier_spectre_desolate_lua:IsDebuff()
	return false
end

function modifier_spectre_desolate_lua:IsStunDebuff()
	return false
end

function modifier_spectre_desolate_lua:IsPurgable()
	return false
end

function modifier_spectre_desolate_lua:AllowIllusionDuplicate()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spectre_desolate_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetParent(),
		damage = self.bonus,
		damage_type = self.abilityDamageType,
		ability = self:GetAbility(), --Optional.
	}
end

function modifier_spectre_desolate_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_spectre_desolate_lua:OnRemoved()
end

function modifier_spectre_desolate_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spectre_desolate_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
	}

	return funcs
end

function modifier_spectre_desolate_lua:OnAttack( params )
	if params.attacker~=self.parent then return end
	if self.parent:PassivesDisabled() then return end

	local enemies = FindUnitsInRadius(
		params.target:GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	-- the target is counted in enemies
	if #enemies>1 then return end

	self.damageTable.victim = params.target
	ApplyDamage(self.damageTable)

	self:PlayEffects( params.target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spectre_desolate_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_spectre/spectre_desolate.vpcf"
	local sound_cast = "Hero_Spectre.Desolate"

	-- Get Data
	local forward = (target:GetOrigin()-self.parent:GetOrigin()):Normalized()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 4, target:GetOrigin() )
	ParticleManager:SetParticleControlForward( effect_cast, 0, forward )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end