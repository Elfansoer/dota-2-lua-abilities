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
modifier_hoodwink_bushwhack_lua_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_bushwhack_lua_thinker:IsHidden()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsDebuff()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsStunDebuff()
	return false
end

function modifier_hoodwink_bushwhack_lua_thinker:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_bushwhack_lua_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "total_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "debuff_duration" )
	self.speed = self:GetAbility():GetSpecialValueFor( "projectile_speed" )
	self.radius = self:GetAbility():GetSpecialValueFor( "trap_radius" )

	if not IsServer() then return end

	self.location = self:GetParent():GetOrigin()
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	self:PlayEffects1()
end

function modifier_hoodwink_bushwhack_lua_thinker:OnRefresh( kv )
	
end

function modifier_hoodwink_bushwhack_lua_thinker:OnRemoved()
end

function modifier_hoodwink_bushwhack_lua_thinker:OnDestroy()
	if not IsServer() then return end

	-- vision
	AddFOWViewer( self.caster:GetTeamNumber(), self.location, self.radius, self.duration, false )

	-- find enemies
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),	-- int, your team number
		self.location,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	if #enemies<1 then
		self:PlayEffects2( false )
		return
	end

	-- find trees
	local trees = GridNav:GetAllTreesAroundPoint( self.location, self.radius, false )
	if #trees<1 then
		self:PlayEffects2( false )
		return
	end

	-- precache damage
	local damageTable = {
		-- victim = target,
		attacker = self.caster,
		damage = self.damage,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	
	-- match enemies with closest trees
	for _,enemy in pairs(enemies) do

		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- get closest tree
		local origin = enemy:GetOrigin()
		local mytree = trees[1]
		local mytreedist = (trees[1]:GetOrigin()-origin):Length2D()
		for _,tree in pairs(trees) do
			local treedist = (tree:GetOrigin()-origin):Length2D()
			if treedist<mytreedist then
				mytree = tree
				mytreedist = treedist
			end
		end

		enemy:AddNewModifier(
			self.caster, -- player source
			self.ability, -- ability source
			"modifier_hoodwink_bushwhack_lua_debuff", -- modifier name
			{
				duration = self.duration,
				tree = mytree:entindex(),
			} -- kv
		)

	end

	-- play effects
	self:PlayEffects2( true )

	UTIL_Remove( self:GetParent() )
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hoodwink_bushwhack_lua_thinker:OnIntervalThink()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hoodwink_bushwhack_lua_thinker:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_projectile.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.caster:GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.speed, 0, 0 ) )

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
	EmitSoundOn( sound_cast, self.caster )
end

function modifier_hoodwink_bushwhack_lua_thinker:PlayEffects2( success )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_fail.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Cast"
	local sound_location = "Hero_Hoodwink.Bushwhack.Impact"
	if success then
		particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack.vpcf"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.location )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	StopSoundOn( sound_cast, self.caster )
	EmitSoundOnLocationWithCaster( self.location, sound_location, self.caster )
end