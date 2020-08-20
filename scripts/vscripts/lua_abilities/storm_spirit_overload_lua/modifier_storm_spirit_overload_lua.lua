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
modifier_storm_spirit_overload_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_overload_lua:IsHidden()
	return true
end

function modifier_storm_spirit_overload_lua:IsDebuff()
	return false
end

function modifier_storm_spirit_overload_lua:IsStunDebuff()
	return false
end

function modifier_storm_spirit_overload_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_overload_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "overload_aoe" )
	local damage = self:GetAbility():GetSpecialValueFor( "overload_damage" )

	if not IsServer() then return end
	self.duration = self:GetAbility():GetDuration()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability, --Optional.
	}

	self.records = {}
end

function modifier_storm_spirit_overload_lua:OnRefresh( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "overload_aoe" )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "overload_attack_slow" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "overload_move_slow" )
	local damage = self:GetAbility():GetSpecialValueFor( "overload_damage" )

	if not IsServer() then return end
	self.duration = self:GetAbility():GetDuration()

	-- precache damage
	self.damageTable.damage = damage
end

function modifier_storm_spirit_overload_lua:OnRemoved()
end

function modifier_storm_spirit_overload_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_storm_spirit_overload_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,

		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_storm_spirit_overload_lua:OnAbilityFullyCast( params )
	if not IsServer() then return end
	if params.unit~=self.parent then return end

	-- not for items
	if params.ability:IsItem() then return end

	-- not if break
	if self.parent:PassivesDisabled() then return end

	-- add buff
	self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_storm_spirit_overload_lua_buff", -- modifier name
		{} -- kv
	)
end

function modifier_storm_spirit_overload_lua:OnAttack( params )
	if not IsServer() then return end
	if params.attacker~=self.parent then return end
	if params.target:GetTeamNumber()==self.parent:GetTeamNumber() then return end

	-- only when active
	local modifier = self.parent:FindModifierByNameAndCaster( "modifier_storm_spirit_overload_lua_buff", self.parent )
	if not modifier then return end

	-- record attack
	self.records[params.record] = true

	-- destroy modifier
	modifier:Destroy()
end

function modifier_storm_spirit_overload_lua:OnAttackRecordDestroy( params )
	if not IsServer() then return end
	if not self.records[params.record] then return end

	-- delete record
	self.records[params.record] = nil
end

function modifier_storm_spirit_overload_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end

	-- only for recorded attacks
	if not self.records[params.record] then return end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- slow
		enemy:AddNewModifier(
			self.parent, -- player source
			self.ability, -- ability source
			"modifier_storm_spirit_overload_lua_debuff", -- modifier name
			{ duration = self.duration } -- kv
		)
	end

	-- play effects
	self:PlayEffects( params.target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_storm_spirit_overload_lua:PlayEffects( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
	local sound_cast = "Hero_StormSpirit.Overload"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

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
	EmitSoundOn( sound_cast, target )
end