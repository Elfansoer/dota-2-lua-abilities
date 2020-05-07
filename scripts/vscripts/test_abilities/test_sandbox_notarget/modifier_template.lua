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
modifier_template = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_template:IsHidden()
	return false
end

function modifier_template:IsDebuff()
	return false
end

function modifier_template:IsStunDebuff()
	return false
end

function modifier_template:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_template:OnCreated( kv )

	if not IsServer() then return end

	self.target = EntIndexToHScript( kv.tree )
	local speed = kv.speed

	-- references
	self.origin = self:GetParent():GetOrigin()

	local vec = self.target:GetOrigin() - self.origin
	vec.z = 0

	self.distance = vec:Length2D()
	self.duration = self.distance/speed
	self.height = 192
	self.direction = vec:Normalized()

	-- horizontal motion
	-- self.duration = 0.45
	-- self.distance = 550
	-- self.height = 150
	-- self.direction = self:GetParent():GetForwardVector()

	-- obtain final height
	local pos = self.target:GetOrigin()
	local ground = GetGroundHeight( pos, self:GetParent() )
	local diff = 128 + ground - self.origin.z


	self:InitVerticalArc( self.height, diff, self.duration )

	self:SetDuration( self.duration, true )
	self:ApplyHorizontalMotionController()
	self:ApplyVerticalMotionController()

	self.total1 = 0
	self.total2 = 0
end

function modifier_template:OnRefresh( kv )
	
end

function modifier_template:OnRemoved()
end

function modifier_template:OnDestroy()
	if not IsServer() then return end
	self:GetParent():InterruptMotionControllers( true )
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_template:UpdateHorizontalMotion( me, dt )
	local time = self.total2/self.duration
	local pos = self.origin + self.direction * self.distance * time

	me:SetOrigin( pos )

	self.total2 = self.total2 + dt
end

function modifier_template:OnHorizontalMotionInterrupted()
end

function modifier_template:UpdateVerticalMotion( me, dt )

	-- -- absolute
	-- local height = self.origin.z + self:f( self.total1 )
	-- local pos = me:GetOrigin()
	-- pos.z = height
	-- me:SetOrigin( pos )

	-- relative
	local pos = me:GetOrigin()

	local height = pos.z
	local change = self:df( self.total1 )
	pos.z = height + change * dt
	me:SetOrigin( pos )

	self.total1 = self.total1 + dt
end

function modifier_template:OnVerticalMotionInterrupted()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_template:f(x)
	return self.const1*x - self.const2*x*x
end

function modifier_template:df(x)
	return self.const1 - 2*self.const2*x
end

function modifier_template:InitVerticalArc( height_max, height_end, duration )
	-- obtain max height
	local avg = height_end/2
	height_max = height_max + avg
	if height_max<height_end then
		height_max = height_end+10
	end
	if height_max<=0 then
		height_max = 10
	end

	-- math magic
	local duration_end = ( 1 + math.sqrt( 1 - height_end/height_max ) )/2
	self.const1 = 4*height_max*duration_end/duration
	self.const2 = 4*height_max*duration_end*duration_end/(duration*duration)
end

function modifier_template:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_template:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end


-- --------------------------------------------------------------------------------
-- -- Graphics & Animations
-- function modifier_template:GetEffectName()
-- 	return "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- end

-- function modifier_template:GetEffectAttachType()
-- 	return PATTACH_ABSORIGIN_FOLLOW
-- end

-- function modifier_template:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_template:PlayEffects()
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
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
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