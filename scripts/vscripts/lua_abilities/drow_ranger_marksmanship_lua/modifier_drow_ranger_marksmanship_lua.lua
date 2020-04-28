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
modifier_drow_ranger_marksmanship_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_drow_ranger_marksmanship_lua:IsHidden()
	return true
end

function modifier_drow_ranger_marksmanship_lua:IsDebuff()
	return false
end

function modifier_drow_ranger_marksmanship_lua:IsPurgable()
	return false
end

function modifier_drow_ranger_marksmanship_lua:GetPriority()
	return MODIFIER_PRIORITY_LOW
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_drow_ranger_marksmanship_lua:OnCreated( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.disable = self:GetAbility():GetSpecialValueFor( "disable_range" )
	self.radius = self:GetAbility():GetSpecialValueFor( "agility_range" )
	self.split_range = self:GetAbility():GetSpecialValueFor( "scepter_range" )
	self.split_count = self:GetAbility():GetSpecialValueFor( "split_count_scepter" )
	self.split_damage = self:GetAbility():GetSpecialValueFor( "damage_reduction_scepter" )

	self.active = true

	if not IsServer() then return end
	self.records = {}
	self.procs = false

	-- precache splinter
	self.info = {
		-- Target = target,
		-- Source = self:GetParent(),
		Ability = self:GetAbility(),	
		
		EffectName = self:GetParent():GetRangedProjectileName(),
		iMoveSpeed = self:GetParent():GetProjectileSpeed(),
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,		
	
		bDodgeable = true,                           -- Optional
		bIsAttack = true,                                -- Optional

		ExtraData = {},
	}
	-- ProjectileManager:CreateTrackingProjectile(info)

	-- Start interval
	self:StartIntervalThink( 0.1 )

	-- play effects
	self:PlayEffects1()
end

function modifier_drow_ranger_marksmanship_lua:OnRefresh( kv )
	-- references
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.damage = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.disable = self:GetAbility():GetSpecialValueFor( "disable_range" )
	self.radius = self:GetAbility():GetSpecialValueFor( "agility_range" )	
end

function modifier_drow_ranger_marksmanship_lua:OnRemoved()
end

function modifier_drow_ranger_marksmanship_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_drow_ranger_marksmanship_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_RECORD_DESTROY,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,

		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,

		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}

	return funcs
end

function modifier_drow_ranger_marksmanship_lua:OnAttackStart( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end

	-- cancel if inactive
	if not self.active then return end

	-- roll chance happens here, so that projectile_name can check if procs
	local rand = RandomInt( 0, 100 )
	if rand>self.chance then return end
	self.procs = true
end

function modifier_drow_ranger_marksmanship_lua:OnAttack( params )
	if not IsServer() then return end
	if params.attacker~=self:GetParent() then return end

	-- check if split shot and procs
	if self:GetAbility().split and self:GetAbility().split_procs then
		self.procs = true
	end

	-- check if procs
	if not self.procs then return end
	self.procs = false

	-- procs, record attack
	self.records[params.record] = true
end

function modifier_drow_ranger_marksmanship_lua:OnAttackLanded( params )
	if not self.records[params.record] then return end

	-- add ignore armor modifier
	local modifier = params.target:AddNewModifier(
		self:GetParent(), -- player source
		self:GetAbility(), -- ability source
		"modifier_drow_ranger_marksmanship_lua_debuff", -- modifier name
		{ duration = 0.5 } -- kv
	)

	self.records[params.record] = modifier
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProcAttack_BonusDamage_Physical( params )
	if not IsServer() then return end
	if not self.records[params.record] then return end
	return self.damage
end

function modifier_drow_ranger_marksmanship_lua:OnAttackRecordDestroy( params )
	if not self.records[params.record] then return end

	-- destroy record, and immediately destroy ignore armor modifier
	local modifier = self.records[params.record]
	if type(modifier)=='table' and not modifier:IsNull() then modifier:Destroy() end
	self.records[params.record] = nil
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProjectileName( params )
	if not IsServer() then return end
	
	-- check procs
	if not self.procs then return end

	return "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
end

function modifier_drow_ranger_marksmanship_lua:GetModifierProcAttack_Feedback( params )
	if not IsServer() then return end

	-- for scepter
	if not self:GetParent():HasScepter() then return end

	-- check if this is split shot
	if self:GetAbility().split then return end

	-- find enemies
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.split_range,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local count = 0
	for _,enemy in pairs(enemies) do
		if enemy~=params.target and count<self.split_count then

			-- roll pierce armor chance
			local procs = false
			local rand = RandomInt( 0, 100 )
			if self.active and rand<=self.chance then
				procs = true
			end

			-- launch projectile
			self.info.Target = enemy
			self.info.Source = params.target
			if procs then
				self.info.EffectName = "particles/units/heroes/hero_drow/drow_marksmanship_attack.vpcf"
				self.info.ExtraData = {
					procs = true,
				}
			else
				self.info.EffectName = self:GetParent():GetRangedProjectileName()
				self.info.ExtraData = {
					procs = false,
				}
			end
			ProjectileManager:CreateTrackingProjectile( self.info )

			count = count+1
		end
	end
end

function modifier_drow_ranger_marksmanship_lua:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then return end
	
	-- check if split shot
	if self:GetAbility().split then
		return -self.split_damage
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_drow_ranger_marksmanship_lua:OnIntervalThink()
	-- check for enemy
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.disable,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local no_enemies = #enemies==0

	-- check if change state
	if self.active ~= no_enemies then
		self:PlayEffects2( no_enemies )
		self.active = no_enemies
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_drow_ranger_marksmanship_lua:IsAura()
	return self.active
end

function modifier_drow_ranger_marksmanship_lua:GetModifierAura()
	return "modifier_drow_ranger_marksmanship_lua_effect"
end

function modifier_drow_ranger_marksmanship_lua:GetAuraRadius()
	return self.radius
end

function modifier_drow_ranger_marksmanship_lua:GetAuraDuration()
	return 0.5
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

function modifier_drow_ranger_marksmanship_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_RANGED_ONLY
end

function modifier_drow_ranger_marksmanship_lua:GetAuraEntityReject( hEntity )
	if IsServer() then

	end

	return false
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_drow_ranger_marksmanship_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship.vpcf"
 
	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )

	-- set glowing
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(2,0,0) )

	-- skip bow particle CP
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	3,
	-- 	self:GetParent(),
	-- 	PATTACH_POINT_FOLLOW,
	-- 	"bow_top",
	-- 	Vector(0,0,0), -- unknown
	-- 	true -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	5,
	-- 	self:GetParent(),
	-- 	PATTACH_POINT_FOLLOW,
	-- 	"bow_bot",
	-- 	Vector(0,0,0), -- unknown
	-- 	true -- unknown, true
	-- )

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self:PlayEffects2( true )
end

function modifier_drow_ranger_marksmanship_lua:PlayEffects2( start )
	-- turn on/off cold effect
	local state = 1
	if start then state = 2 end
	ParticleManager:SetParticleControl( self.effect_cast, 2, Vector(state,0,0) )

	-- play start effect
	if not start then return end

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_drow/drow_marksmanship_start.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end