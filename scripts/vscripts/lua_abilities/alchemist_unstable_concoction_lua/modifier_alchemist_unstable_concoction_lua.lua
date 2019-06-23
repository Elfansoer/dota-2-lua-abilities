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
modifier_alchemist_unstable_concoction_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_alchemist_unstable_concoction_lua:IsHidden()
	return true
end

function modifier_alchemist_unstable_concoction_lua:IsDebuff()
	return false
end

function modifier_alchemist_unstable_concoction_lua:IsStunDebuff()
	return false
end

function modifier_alchemist_unstable_concoction_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_alchemist_unstable_concoction_lua:OnCreated( kv )
	-- references
	self.min_stun = self:GetAbility():GetSpecialValueFor( "min_stun" )
	self.max_stun = self:GetAbility():GetSpecialValueFor( "max_stun" )
	self.min_damage = self:GetAbility():GetSpecialValueFor( "min_damage" )
	self.max_damage = self:GetAbility():GetSpecialValueFor( "max_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	self.tick_interval = 0.5
	self.tick = kv.duration
	self.tick_halfway = true

	-- Start interval
	self:StartIntervalThink( self.tick_interval )

	-- play effects
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Fuse"
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_alchemist_unstable_concoction_lua:OnRefresh( kv )
	
end

function modifier_alchemist_unstable_concoction_lua:OnRemoved()
end

function modifier_alchemist_unstable_concoction_lua:OnDestroy()
	if not IsServer() then return end

	-- play effects
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Fuse"
	StopSoundOn( sound_cast, self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_alchemist_unstable_concoction_lua:OnIntervalThink()
	-- tick
	self.tick = self.tick - self.tick_interval
	if self.tick>0 then
		-- play tick effects
		self.tick_halfway = not self.tick_halfway
		self:PlayEffects2()
		return
	end

	-- explode on head
	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = self.max_damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- find units in radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- debuff
		enemy:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = self.max_stun } -- kv
		)
	end

	-- also damages and stuns caster if not invulnerable
	if not self:GetParent():IsInvulnerable() then
		damageTable.victim = self:GetParent()
		ApplyDamage( damageTable )

		-- debuff
		self:GetParent():AddNewModifier(
			self:GetParent(), -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_stunned_lua", -- modifier name
			{ duration = self.max_stun } -- kv
		)
	end

	-- switch ability layout
	local ability = self:GetCaster():FindAbilityByName( "alchemist_unstable_concoction_throw_lua" )
	self:GetCaster():SwapAbilities(
		self:GetAbility():GetAbilityName(),
		ability:GetAbilityName(),
		true,
		false
	)

	-- remove if stolen
	if ability:IsStolen() then
		self:GetCaster():RemoveAbilityByHandle( ability )
	end

	-- Play effects
	self:PlayEffects1( self:GetParent() )

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_alchemist_unstable_concoction_lua:PlayEffects1( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf"
	local sound_cast = "Hero_Alchemist.UnstableConcoction.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
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

function modifier_alchemist_unstable_concoction_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_timer.vpcf"

	-- Get data
	local time = math.floor( self.tick )
	local mid = 1
	if self.tick_halfway then mid = 8 end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, time, mid ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 2, 0, 0 ) )

	if time<1 then
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
	end

	ParticleManager:ReleaseParticleIndex( effect_cast )
end