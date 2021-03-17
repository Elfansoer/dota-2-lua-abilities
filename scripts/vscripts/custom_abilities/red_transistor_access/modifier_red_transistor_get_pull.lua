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
modifier_red_transistor_get_pull = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_get_pull:IsHidden()
	return false
end

function modifier_red_transistor_get_pull:IsDebuff()
	return true
end

function modifier_red_transistor_get_pull:IsStunDebuff()
	return false
end

function modifier_red_transistor_get_pull:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_get_pull:OnCreated( kv )
	if not IsServer() then return end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self.speed = kv.speed
	self.target = Vector( kv.target_x, kv.target_y, 0 )

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end

end

function modifier_red_transistor_get_pull:OnRefresh( kv )
	if not IsServer() then return end
	self.speed = kv.speed
	self.target = Vector( kv.target_x, kv.target_y, 0 )
end

function modifier_red_transistor_get_pull:OnRemoved()
end

function modifier_red_transistor_get_pull:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

-- --------------------------------------------------------------------------------
-- -- Status Effects
-- function modifier_red_transistor_get_pull:CheckState()
-- 	local state = {
-- 		[MODIFIER_STATE_STUNNED] = true,
-- 	}

-- 	return state
-- end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_red_transistor_get_pull:UpdateHorizontalMotion( me, dt )
	local origin = me:GetOrigin()

	-- get direction
	local direction = self.target-origin
	if direction:Length2D()<self.speed*dt then
		me:SetOrigin( origin )
		return
	end

	direction.z = 0
	direction = direction:Normalized()

	me:SetOrigin( origin + direction*self.speed*dt )
end

function modifier_red_transistor_get_pull:OnHorizontalMotionInterrupted()
	self:Destroy()
end

-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_red_transistor_get_pull:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_red_transistor_get_pull:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_red_transistor_get_pull:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_red_transistor_get_pull:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_red_transistor_get_pull:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_POINT_FOLLOW,
-- 		"attach_hitloc",
-- 		Vector(0,0,0), -- unknown
-- 		true -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- buff particle
-- 	self:AddParticle(
-- 		effect_cast,
-- 		false, -- bDestroyImmediately
-- 		false, -- bStatusEffect
-- 		-1, -- iPriority
-- 		false, -- bHeroEffect
-- 		false -- bOverheadEffect
-- 	)

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end