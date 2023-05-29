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
modifier_spirit_breaker_greater_bash_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_spirit_breaker_greater_bash_lua:IsHidden()
	return true
end

function modifier_spirit_breaker_greater_bash_lua:IsDebuff()
	return false
end

function modifier_spirit_breaker_greater_bash_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_spirit_breaker_greater_bash_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.pseudoseed = RandomInt( 1, 100 )

	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance_pct" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	self.knockback_duration = self:GetAbility():GetSpecialValueFor( "knockback_duration" )
	self.knockback_distance = self:GetAbility():GetSpecialValueFor( "knockback_distance" )
	self.knockback_height = self:GetAbility():GetSpecialValueFor( "knockback_height" )

	self.movespeed_pct = self:GetAbility():GetSpecialValueFor( "bonus_movespeed_pct" )
	self.movespeed_duration = self:GetAbility():GetSpecialValueFor( "movespeed_duration" )


	if not IsServer() then return end
end

function modifier_spirit_breaker_greater_bash_lua:OnRefresh( kv )
	self:OnCreated( kv )	
end

function modifier_spirit_breaker_greater_bash_lua:OnRemoved()
end

function modifier_spirit_breaker_greater_bash_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_spirit_breaker_greater_bash_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_spirit_breaker_greater_bash_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end
	if self.parent:PassivesDisabled() then return end
	if not self.ability:IsFullyCastable() then return end

	-- unit filter
	local filter = UnitFilter(
		params.target,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self.parent:GetTeamNumber()
	)
	if filter~=UF_SUCCESS then return end

	-- roll pseudo random
	if not RollPseudoRandomPercentage( self.chance, self.pseudoseed, self.parent ) then return end

	-- set cooldown
	self.ability:UseResources( false, false, false, true )

	-- proc
	self:Bash( params.target, false )
end

--------------------------------------------------------------------------------
-- Helper
function modifier_spirit_breaker_greater_bash_lua:Bash( target, double )
	local direction = target:GetOrigin()-self.parent:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local dist = self.knockback_distance
	if double then
		dist = dist*2
	end

	-- create arc
	target:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			dir_x = direction.x,
			dir_y = direction.y,
			duration = self.knockback_duration,
			distance = dist,
			height = self.knockback_height,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)

	-- stun
	target:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.duration } -- kv
	)

	-- calculate damage
	local damage = self.parent:GetIdealSpeed() * self.damage/100

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = self.parent,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability, --Optional.
	}
	ApplyDamage(damageTable)

	-- apply bonus damage
	damageTable.damage = damage
	ApplyDamage( damageTable )

	-- play effects
	self:PlayEffects( target, target:IsCreep() )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_spirit_breaker_greater_bash_lua:PlayEffects( target, isCreep )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf"
	local sound_cast = "Hero_Spirit_Breaker.GreaterBash"
	if isCreep then
		sound_cast = "Hero_Spirit_Breaker.GreaterBash.Creep"
	end

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
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end