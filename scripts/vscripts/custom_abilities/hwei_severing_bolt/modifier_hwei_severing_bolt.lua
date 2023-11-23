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
modifier_hwei_severing_bolt = class({})

--------------------------------------------------------------------------------
-- Initializations
function modifier_hwei_severing_bolt:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	
	if not IsServer() then return end
	self.damage_type = self.ability:GetAbilityDamageType()

	self.parent:SetOrigin( self.parent:GetOrigin() + Vector( 0, 0, 50 ) )
	AddFOWViewer(self.caster:GetTeamNumber(), self.parent:GetOrigin(), self.radius, self:GetDuration(), false)

	self:PlayEffectsStart()
end

function modifier_hwei_severing_bolt:OnRefresh( kv )
end

function modifier_hwei_severing_bolt:OnRemoved()
end

function modifier_hwei_severing_bolt:OnDestroy()
	if not IsServer() then return end

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

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self.caster,
		-- damage = self.damage,
		damage_type = self.damage_type,
		ability = self.ability, --Optional.
	}

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.damage = self.damage + self.damage * (100 - enemy:GetHealthPercent())/100
		damageTable.victim = enemy
		ApplyDamage( damageTable )
	end

	-- play effects
	self:PlayEffectsExplode()

	UTIL_Remove( self.parent )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hwei_severing_bolt:PlayEffectsStart()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_buff.vpcf"
	local sound_target = "Hero_Grimstroke.InkSwell.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		self:GetParent():GetOrigin(), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		effect_cast,
		false,
		false,
		-1,
		false,
		true
	)

	-- Create Sound
	EmitSoundOn( sound_target, self.caster )
end


function modifier_hwei_severing_bolt:PlayEffectsExplode()
	-- stop sound
	local sound_end = "Hero_Grimstroke.InkSwell.Cast"
	StopSoundOn( sound_end, self.caster )
	
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_ink_swell_aoe.vpcf"
	local sound_target = "Hero_Grimstroke.InkSwell.Stun"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.radius, self.radius, self.radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, self.caster )
end