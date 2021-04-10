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
modifier_dawnbreaker_luminosity_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_luminosity_lua:IsHidden()
	return self:GetStackCount()<1
end

function modifier_dawnbreaker_luminosity_lua:IsDebuff()
	return false
end

function modifier_dawnbreaker_luminosity_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_luminosity_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "attack_count" )
	self.heal = self:GetAbility():GetSpecialValueFor( "heal_pct" )
	self.radius = self:GetAbility():GetSpecialValueFor( "heal_radius" )
	self.crit = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.allyheal = self:GetAbility():GetSpecialValueFor( "allied_healing_pct" )
	self.creepheal = self:GetAbility():GetSpecialValueFor( "heal_from_creeps" )

	if not IsServer() then return end

	-- for multi-hit using starbreaker
	self.total_heal = 0
	self.allies = {}
end

function modifier_dawnbreaker_luminosity_lua:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_dawnbreaker_luminosity_lua:OnRemoved()
end

function modifier_dawnbreaker_luminosity_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_luminosity_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_dawnbreaker_luminosity_lua:GetModifierPreAttack_CriticalStrike()
	if self:GetStackCount()<self.count then return 0 end
	return self.crit 
end

function modifier_dawnbreaker_luminosity_lua:GetModifierProcAttack_Feedback( params )
	-- procs
	if self:GetStackCount()==self.count then
		self:Proc( params )
	end

	-- if caster has starbreak, let starbreak do the increase
	if self.parent:HasModifier( "modifier_dawnbreaker_starbreaker_lua" ) then return end
	self:Increment()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_dawnbreaker_luminosity_lua:Increment()
	-- when break, no increment, or if at max stack, do only the crit
	if self.parent:PassivesDisabled() then
		if self:GetStackCount()==self.count then

			-- reset counter
			self.total_heal = 0
			self.allies = {}
			self:SetStackCount( 0 )
			self:StopEffects()
		end
		return
	end

	-- add stack
	self:IncrementStackCount()
	if self:GetStackCount()>self.count then
		-- overhead heal info
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_HEAL,
			self.parent,
			self.total_heal,
			self.parent:GetPlayerOwner()
		)
		local allyheal = self.total_heal * self.allyheal/100
		for ally,_ in pairs(self.allies) do
			SendOverheadEventMessage(
				nil,
				OVERHEAD_ALERT_HEAL,
				ally,
				allyheal,
				self.parent:GetPlayerOwner()
			)
		end

		-- reset counter
		self.total_heal = 0
		self.allies = {}
		self:SetStackCount( 0 )
		self:StopEffects()
	end

	-- play effects
	if self:GetStackCount()==self.count then
		self:PlayEffects1()
	end
end

function modifier_dawnbreaker_luminosity_lua:Proc( params )
	-- only crit, no stack if break
	if self.parent:PassivesDisabled() then return end	

	-- calculate heal
	local heal = params.damage * self.heal/100
	if params.target:IsCreep() then
		heal = heal * self.creepheal/100
	end

	-- heal self
	self.parent:Heal( heal, self.ability )
	self.total_heal = self.total_heal + heal

	-- find allies
	local allies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- set allied heal
	heal = heal * self.allyheal/100

	for _,ally in pairs(allies) do
		if ally~=self.parent then
			-- heal
			ally:Heal( heal, self.ability )
			self.allies[ally] = true

			-- play effects
			self:PlayEffects2( params.target, ally )
		end
	end

	-- play effects
	self:PlayEffects2( params.target, self.parent )
	local sound_cast = "Hero_Dawnbreaker.Luminosity.Strike"
	EmitSoundOn( sound_cast, params.target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_luminosity_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity_attack_buff.vpcf"
	local sound_cast = "Hero_Dawnbreaker.Luminosity.PowerUp"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		2,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dawnbreaker_luminosity_lua:PlayEffects2( target, ally )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_luminosity.vpcf"
	local sound_target = "Hero_Dawnbreaker.Luminosity.Heal"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, ally )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		ally,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 1, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_target, ally )
end

function modifier_dawnbreaker_luminosity_lua:StopEffects()
	ParticleManager:DestroyParticle( self.effect_cast, false )
	ParticleManager:ReleaseParticleIndex( self.effect_cast )
end