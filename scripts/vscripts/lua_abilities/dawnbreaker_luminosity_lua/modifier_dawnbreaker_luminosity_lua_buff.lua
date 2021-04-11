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
modifier_dawnbreaker_luminosity_lua_buff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dawnbreaker_luminosity_lua_buff:IsHidden()
	return false
end

function modifier_dawnbreaker_luminosity_lua_buff:IsDebuff()
	return false
end

function modifier_dawnbreaker_luminosity_lua_buff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dawnbreaker_luminosity_lua_buff:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.heal = self:GetAbility():GetSpecialValueFor( "heal_pct" )
	self.radius = self:GetAbility():GetSpecialValueFor( "heal_radius" )
	self.crit = self:GetAbility():GetSpecialValueFor( "bonus_damage" )
	self.allyheal = self:GetAbility():GetSpecialValueFor( "allied_healing_pct" )
	self.creepheal = self:GetAbility():GetSpecialValueFor( "heal_from_creeps" )

	if not IsServer() then return end

	-- for multi-hit using starbreaker
	self.passive = false
	self.total_heal = 0
	self.allies = {}

	-- play effects
	self:PlayEffects1()
end

function modifier_dawnbreaker_luminosity_lua_buff:OnRefresh( kv )
end

function modifier_dawnbreaker_luminosity_lua_buff:OnRemoved()
end

function modifier_dawnbreaker_luminosity_lua_buff:OnDestroy()
	if not IsServer() then return end
	if not self.passive then
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
	end

	-- reset counter
	self.passive = false
	self.total_heal = 0
	self.allies = {}
	self.modifier:SetStackCount( 0 )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_dawnbreaker_luminosity_lua_buff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}

	return funcs
end

function modifier_dawnbreaker_luminosity_lua_buff:GetModifierPreAttack_CriticalStrike()
	return self.crit 
end

function modifier_dawnbreaker_luminosity_lua_buff:GetModifierProcAttack_Feedback( params )
	-- only crit, no stack if break
	if self.parent:PassivesDisabled() then
		-- is passive
		self.passive = true

		-- destroy (or will be destroyed by starbreaker)
		if self.parent:HasModifier( "modifier_dawnbreaker_starbreaker_lua" ) then return end
		self:Destroy()
		return
	end

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

	-- destroy (or will be destroyed by starbreaker)
	if self.parent:HasModifier( "modifier_dawnbreaker_starbreaker_lua" ) then return end
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dawnbreaker_luminosity_lua_buff:PlayEffects1()
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
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_dawnbreaker_luminosity_lua_buff:PlayEffects2( target, ally )
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