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
modifier_wisp_ambient = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_wisp_ambient:IsHidden()
	return false
end

function modifier_wisp_ambient:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_wisp_ambient:OnCreated( kv )
	if not IsServer() then return end
	self:GetParent():SetModel( "models/heroes/dark_willow/dark_willow_wisp.vmdl" )

	self:PlayEffects()
end

function modifier_wisp_ambient:OnRefresh( kv )
	
end

function modifier_wisp_ambient:OnRemoved()
end

function modifier_wisp_ambient:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_wisp_ambient:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_wisp_ambient:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_wisp_ambient:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_dark_willow/dark_willow_willowisp_ambient.vpcf"

	-- Create Particle
	-- local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	local effect_cast = assert(loadfile("lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_lua_arcana"))(self, particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
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
end