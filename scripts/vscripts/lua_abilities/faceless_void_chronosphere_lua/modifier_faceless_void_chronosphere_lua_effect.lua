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
modifier_faceless_void_chronosphere_lua_effect = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_faceless_void_chronosphere_lua_effect:IsHidden()
	return false
end

function modifier_faceless_void_chronosphere_lua_effect:IsDebuff()
	return not self:NotAffected()
end

function modifier_faceless_void_chronosphere_lua_effect:IsStunDebuff()
	return not self:NotAffected()
end

function modifier_faceless_void_chronosphere_lua_effect:IsPurgable()
	return false
end

function modifier_faceless_void_chronosphere_lua_effect:GetPriority()
	return MODIFIER_PRIORITY_ULTRA
end

function modifier_faceless_void_chronosphere_lua_effect:NotAffected()
	-- true owner
	if self:GetParent()==self:GetCaster() then return true end

	-- true if owner controlled
	if self:GetParent():GetPlayerOwnerID()==self:GetCaster():GetPlayerOwnerID() then return true end
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_faceless_void_chronosphere_lua_effect:OnCreated( kv )
	self.speed = 1000

	if IsServer() then
		if not self:NotAffected() then
			self:GetParent():InterruptMotionControllers( false )
		else
			self:PlayEffects()
		end
	end
end

function modifier_faceless_void_chronosphere_lua_effect:OnRefresh( kv )
	
end

function modifier_faceless_void_chronosphere_lua_effect:OnRemoved()
end

function modifier_faceless_void_chronosphere_lua_effect:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_faceless_void_chronosphere_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}

	return funcs
end

function modifier_faceless_void_chronosphere_lua_effect:GetModifierMoveSpeed_AbsoluteMin()
	if self:NotAffected() then return self.speed end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_faceless_void_chronosphere_lua_effect:CheckState()
	local state1 = {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	local state2 = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_FROZEN] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}

	if self:NotAffected() then return state1 else return state2 end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- function modifier_faceless_void_chronosphere_lua_effect:GetEffectName()
-- 	return "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf"
-- end

-- function modifier_faceless_void_chronosphere_lua_effect:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_faceless_void_chronosphere_lua_effect:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

function modifier_faceless_void_chronosphere_lua_effect:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_faceless_void/faceless_void_chrono_speed.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetParent(),
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
end