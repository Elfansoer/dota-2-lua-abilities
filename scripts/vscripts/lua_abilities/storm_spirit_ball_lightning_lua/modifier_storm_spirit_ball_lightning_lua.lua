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
modifier_storm_spirit_ball_lightning_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_ball_lightning_lua:IsHidden()
	return false
end

function modifier_storm_spirit_ball_lightning_lua:IsDebuff()
	return false
end

function modifier_storm_spirit_ball_lightning_lua:IsStunDebuff()
	return false
end

function modifier_storm_spirit_ball_lightning_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_ball_lightning_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.team = self.parent:GetTeamNumber()

	-- references
	self.mana_flat = self:GetAbility():GetSpecialValueFor( "ball_lightning_travel_cost_base" )
	self.mana_pct = self:GetAbility():GetSpecialValueFor( "ball_lightning_travel_cost_percent" )/100
	self.radius = self:GetAbility():GetSpecialValueFor( "ball_lightning_aoe" )
	self.vision = self:GetAbility():GetSpecialValueFor( "ball_lightning_vision_radius" )
	self.speed = self:GetAbility():GetSpecialValueFor( "ball_lightning_move_speed" )

	if not IsServer() then return end
	-- ability properties
	self.damage = self:GetAbility():GetAbilityDamage()
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- get data
	self.center = Vector( kv.x, kv.y, 0 )
	self.origin = self:GetParent():GetOrigin()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.parent,
		-- damage = 500,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- init
	self.travel_total = 0
	self.tree = 100
	self.tick = 100
	self.enemies = {}

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- play effects
	self:PlayEffects()
end

function modifier_storm_spirit_ball_lightning_lua:OnRefresh( kv )
	
end

function modifier_storm_spirit_ball_lightning_lua:OnRemoved()
end

function modifier_storm_spirit_ball_lightning_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )

	-- stop effects
	local sound_loop = "Hero_StormSpirit.BallLightning.Loop"
	StopSoundOn( sound_loop, self.parent )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_storm_spirit_ball_lightning_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_storm_spirit_ball_lightning_lua:UpdateHorizontalMotion( me, dt )
	-- movement
	local origin = me:GetOrigin()
	local direction = self.center - origin
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()

	local target = origin + direction*self.speed*dt
	me:SetOrigin( target )

	-- damage
	local enemies = FindUnitsInRadius(
		self.team,	-- int, your team number
		origin,	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	for _,enemy in pairs(enemies) do
		if not self.enemies[enemy] then
			-- only hit a unit once
			self.enemies[enemy] = true

			-- damage
			self.damageTable.victim = enemy
			self.damageTable.damage = self.travel_total/self.tick * self.damage
			ApplyDamage( self.damageTable )
		end
	end

	-- destroy trees
	GridNav:DestroyTreesAroundPoint( me:GetOrigin(), self.tree, false )

	-- view
	AddFOWViewer( self.team, origin, self.vision, 0.1, false)

	-- play effects
	ParticleManager:SetParticleControl( self.effect_cast, 1, origin )

	-- reached distance
	if distance<100 then
		self:Destroy()
		return
	end

	-- check mana and damage for every self.tick units
	local travel = (self.origin - me:GetOrigin()):Length2D()
	if travel - self.travel_total<self.tick then return end
	self.travel_total = self.travel_total + self.tick

	-- check mana
	local mana = self:GetParent():GetMana()
	local maxmana = self:GetParent():GetMaxMana()
	local manacost = self.mana_flat + maxmana*self.mana_pct

	if manacost>mana then
		self:Destroy()
		return
	end

	-- spend mana
	me:SpendMana( manacost, hAbility )
end

function modifier_storm_spirit_ball_lightning_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_storm_spirit_ball_lightning_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf"
	local sound_cast = "Hero_StormSpirit.BallLightning"
	local sound_loop = "Hero_StormSpirit.BallLightning.Loop"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, self.parent:GetOrigin() )
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
	EmitSoundOn( sound_loop, self.parent )
end