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
modifier_underlord_dark_rift_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_dark_rift_lua:IsHidden()
	return false
end

function modifier_underlord_dark_rift_lua:IsDebuff()
	return false
end

function modifier_underlord_dark_rift_lua:IsPurgable()
	return false
end

function modifier_underlord_dark_rift_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_dark_rift_lua:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end

	self.success = true

	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_underlord_dark_rift_lua:OnRefresh( kv )
	
end

function modifier_underlord_dark_rift_lua:OnRemoved()
	if not IsServer() then return end
	if not self.success then return end

	local caster = self:GetCaster()

	-- play effects
	self:PlayEffects3()

	-- success teleporting
	local targets = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- teleport units 
	local point = self:GetParent():GetOrigin()
	for _,target in pairs(targets) do
		-- disjoint
		ProjectileManager:ProjectileDodge( target )

		-- move to position
		FindClearSpaceForUnit( target, point, true )
	end

	-- switch ability layout
	local ability = self:GetCaster():FindAbilityByName( "underlord_cancel_dark_rift_lua" )
	if not ability then return end

	caster:SwapAbilities(
		self:GetAbility():GetAbilityName(),
		ability:GetAbilityName(),
		true,
		false
	)
end

function modifier_underlord_dark_rift_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_underlord_dark_rift_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
	}

	return funcs
end

function modifier_underlord_dark_rift_lua:OnDeath( params )
	if not IsServer() then return end

	if params.unit~=self:GetCaster() and params.unit~=self:GetParent() then return end

	-- either caster or target dies, destroy
	self:Cancel()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_underlord_dark_rift_lua:CheckState()
	local state = {
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Helper
function modifier_underlord_dark_rift_lua:Cancel()
	-- cancel teleport
	self.success = false

	-- switch ability layout
	local ability = self:GetCaster():FindAbilityByName( "underlord_cancel_dark_rift_lua" )
	if not ability then return end
	self:GetCaster():SwapAbilities(
		self:GetAbility():GetAbilityName(),
		ability:GetAbilityName(),
		true,
		false
	)

	-- play effects
	self:PlayEffects4()

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_underlord_dark_rift_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/abyssal_underlord_darkrift_target.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.DarkRift.Target"

	-- Get Data
	local parent = self:GetParent()

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
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
	EmitSoundOn( sound_cast, parent )
end

function modifier_underlord_dark_rift_lua:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf"
	local sound_cast = "Hero_AbyssalUnderlord.DarkRift.Cast"

	-- Get Data
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster )
	ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, 0 ) )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, caster )
end

function modifier_underlord_dark_rift_lua:PlayEffects3()
	-- Get Resources
	local sound_cast1 = "Hero_AbyssalUnderlord.DarkRift.Complete"
	local sound_cast2 = "Hero_AbyssalUnderlord.DarkRift.Aftershock"

	-- Get Data
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- Set Effect
	ParticleManager:SetParticleControl( self.effect_cast, 5, caster:GetOrigin() )

	-- Create Sound
	EmitSoundOn( sound_cast1, parent )
	EmitSoundOnLocationWithCaster( caster:GetOrigin(), sound_cast2, caster )
end

function modifier_underlord_dark_rift_lua:PlayEffects4()
	-- Get Resources
	local sound_cast1 = "Hero_AbyssalUnderlord.DarkRift.Cast"
	local sound_cast2 = "Hero_AbyssalUnderlord.DarkRift.Target"
	local sound_cancel = "Hero_AbyssalUnderlord.DarkRift.Cancel"

	-- Get Data
	local caster = self:GetCaster()
	local parent = self:GetParent()

	-- Kill effect
	ParticleManager:DestroyParticle( self.effect_cast, true )

	-- Create Sound
	StopSoundOn( sound_cast1, caster )
	StopSoundOn( sound_cast2, parent )
	EmitSoundOn( sound_cancel, caster )
	EmitSoundOn( sound_cancel, parent )
end