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
modifier_marci_unleash_lua_fury = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_marci_unleash_lua_fury:IsHidden()
	return false
end

function modifier_marci_unleash_lua_fury:IsDebuff()
	return false
end

function modifier_marci_unleash_lua_fury:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_marci_unleash_lua_fury:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.bonus_as = self:GetAbility():GetSpecialValueFor( "flurry_bonus_attack_speed" )
	self.recovery = self:GetAbility():GetSpecialValueFor( "time_between_flurries" )
	self.charges = self:GetAbility():GetSpecialValueFor( "charges_per_flurry" )
	self.timer = self:GetAbility():GetSpecialValueFor( "max_time_window_per_hit" )

	self.radius = self:GetAbility():GetSpecialValueFor( "pulse_radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "pulse_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "pulse_debuff_duration" )

	if not IsServer() then return end

	self.counter = self.charges
	self:SetStackCount( self.counter )

	self.success = 0

	-- create anmiation modifier
	self.animation = self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_marci_unleash_lua_animation", -- modifier name
		{} -- kv
	)

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2( self.parent, self.counter )

end

function modifier_marci_unleash_lua_fury:OnRefresh( kv )
	
end

function modifier_marci_unleash_lua_fury:OnRemoved()
end

function modifier_marci_unleash_lua_fury:OnDestroy()
	if not IsServer() then return end

	-- destroy animation modifier
	if not self.animation:IsNull() then
		self.animation:Destroy()
	end

	-- check main modifier
	local main = self.parent:FindModifierByNameAndCaster( "modifier_marci_unleash_lua", self.parent )
	if not main then return end

	-- check if forced destroy by main modifier
	if self.forced then return end

	-- create recovery modifier
	self.parent:AddNewModifier(
		self.parent, -- player source
		self.ability, -- ability source
		"modifier_marci_unleash_lua_recovery", -- modifier name
		{
			duration = self.recovery,
			success = self.success,
		} -- kv
	)

	if self.success~=1 then return end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_marci_unleash_lua_fury:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_marci_unleash_lua_fury:GetModifierAttackSpeed_Limit()
	return 1
end

function modifier_marci_unleash_lua_fury:GetModifierProcAttack_Feedback( params )
	-- start combo timer
	self:StartIntervalThink( self.timer )

	-- reduce counter
	self.counter = self.counter - 1
	self:SetStackCount( self.counter )

	-- play effects
	self:EditEffects2( self.counter )
	self:PlayEffects3( self.parent, params.target )

	if self.counter<=0 then
		self.success = 1
		self:Pulse( params.target:GetOrigin() )
		self:Destroy()
	end

end

function modifier_marci_unleash_lua_fury:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_as
end

function modifier_marci_unleash_lua_fury:GetActivityTranslationModifiers()
	if self:GetStackCount()==1 then
		return "flurry_pulse_attack"
	end

	if self:GetStackCount()%2==0 then
		return "flurry_attack_b"
	end

	return "flurry_attack_a"
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_marci_unleash_lua_fury:OnIntervalThink()
	-- combo timer expires
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_marci_unleash_lua_fury:Pulse( center )
		-- create pulse
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		center,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = self.damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability, --Optional.
	}

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		-- slow
		enemy:AddNewModifier(
			self.parent, -- player source
			self.ability, -- ability source
			"modifier_marci_unleash_lua_debuff", -- modifier name
			{ duration = self.duration } -- kv
		)
	end

	-- play effects
	self:PlayEffects4( center, self.radius )
end

function modifier_marci_unleash_lua_fury:ForceDestroy()
	self.forced = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_marci_unleash_lua_fury:ShouldUseOverheadOffset()
	return true
end

function modifier_marci_unleash_lua_fury:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_buff.vpcf"
	local sound_cast = "Hero_Marci.Unleash.Charged"
	local sound_cast2 = "Hero_Marci.Unleash.Charged.2D"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"eye_l",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"eye_r",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		4,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

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
	EmitSoundOnClient( sound_cast2, self:GetParent():GetPlayerOwner() )
end

function modifier_marci_unleash_lua_fury:PlayEffects2( caster, counter )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_stack.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, caster )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 0, counter, 0 ) )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		1, -- iPriority
		false, -- bHeroEffect
		true -- bOverheadEffect
	)

	-- save index for later
	self.effect_cast = effect_cast
end

function modifier_marci_unleash_lua_fury:EditEffects2( counter )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( 0, counter, 0 ) )
end

function modifier_marci_unleash_lua_fury:PlayEffects3( caster, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_attack.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_marci_unleash_lua_fury:PlayEffects4( point, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf"
	local sound_cast = "Hero_Marci.Unleash.Pulse"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius,radius,radius) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetParent() )
end
