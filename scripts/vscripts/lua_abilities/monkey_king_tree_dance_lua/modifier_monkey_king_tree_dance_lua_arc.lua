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
modifier_monkey_king_tree_dance_lua_arc = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_monkey_king_tree_dance_lua_arc:IsHidden()
	return false
end

function modifier_monkey_king_tree_dance_lua_arc:IsDebuff()
	return false
end

function modifier_monkey_king_tree_dance_lua_arc:IsStunDebuff()
	return false
end

function modifier_monkey_king_tree_dance_lua_arc:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_monkey_king_tree_dance_lua_arc:OnCreated( kv )
	-- references
	self.dayvision = self:GetAbility():GetSpecialValueFor( "perched_day_vision" )
	self.nightvision = self:GetAbility():GetSpecialValueFor( "perched_night_vision" )

	if not IsServer() then return end
	self.parent = self:GetParent()

	-- load data
	self.speed = kv.speed
	local height_max = kv.height_max
	local height_end = kv.height_end
	local position = Vector( kv.x, kv.y, 0 )
	self.tree = EntIndexToHScript( kv.tree )
	self.perch = kv.perch==1
	self.exit = kv.exit==1 or false

	-- calculate data
	self.origin = self.parent:GetOrigin()
	local vec = position - self.origin
	vec.z = 0

	-- get horizontal positions
	self.distance = vec:Length2D()
	self.direction = vec:Normalized()
	self.duration = self.distance/self.speed

	-- calculate arc
	self:InitVerticalArc( height_max, height_end, self.duration )
	self.total_time = 0

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
	if not self:ApplyVerticalMotionController() then
		self.interrupted = true
		self:Destroy()
	end

	-- initialization
	self:SetDuration( self.duration, true )
	if self.perch then
		self.parent:SetOrigin( self.origin )
	end

	-- set cooldown
	self:GetAbility():StartCooldown( self.duration + self:GetAbility():GetEffectiveCooldown( self:GetAbility():GetLevel() ) )
end

function modifier_monkey_king_tree_dance_lua_arc:OnRefresh( kv )
	
end

function modifier_monkey_king_tree_dance_lua_arc:OnRemoved()
end

function modifier_monkey_king_tree_dance_lua_arc:OnDestroy()
	if not IsServer() then return end

	local interrupted = self.interrupted or false
	self:GetParent():InterruptMotionControllers( interrupted or self.exit )

	if interrupted then return end

	if self.exit then return end

	-- add perch modifier
	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_monkey_king_tree_dance_lua", -- modifier name
		{
			tree = self.tree:entindex(),
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_monkey_king_tree_dance_lua_arc:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,

		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_monkey_king_tree_dance_lua_arc:GetFixedDayVision()
	return self.dayvision
end

function modifier_monkey_king_tree_dance_lua_arc:GetFixedNightVision()
	return self.nightvision
end

function modifier_monkey_king_tree_dance_lua_arc:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end
--------------------------------------------------------------------------------
-- Status Effects
function modifier_monkey_king_tree_dance_lua_arc:CheckState()
	local state = {
		[MODIFIER_STATE_FLYING] = not self.exit,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = self.exit,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_STUNNED] = not self.exit,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_monkey_king_tree_dance_lua_arc:UpdateHorizontalMotion( me, dt )
	if self.total_time>=self.duration-dt then return end

	-- set relative position
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_monkey_king_tree_dance_lua_arc:OnHorizontalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

function modifier_monkey_king_tree_dance_lua_arc:UpdateVerticalMotion( me, dt )
	if self.total_time>=self.duration then return end

	local pos = me:GetOrigin()

	-- set relative position
	local height = pos.z
	local speed = self:GetVerticalSpeed( self.total_time )
	pos.z = height + speed * dt
	me:SetOrigin( pos )

	self.total_time = self.total_time + dt
end

function modifier_monkey_king_tree_dance_lua_arc:OnVerticalMotionInterrupted()
	self.interrupted = true
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_monkey_king_tree_dance_lua_arc:InitVerticalArc( height_max, height_end, duration )
	-- obtain proper max height
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

function modifier_monkey_king_tree_dance_lua_arc:GetVerticalPos( time )
	return self.const1*time - self.const2*time*time
end

function modifier_monkey_king_tree_dance_lua_arc:GetVerticalSpeed( time )
	return self.const1 - 2*self.const2*time
end


--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_monkey_king_tree_dance_lua_arc:GetEffectName()
	return "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf"
end

function modifier_monkey_king_tree_dance_lua_arc:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-- function modifier_monkey_king_tree_dance_lua_arc:GetStatusEffectName()
-- 	return "status/effect/here.vpcf"
-- end

-- function modifier_monkey_king_tree_dance_lua_arc:StatusEffectPriority()
-- 	return MODIFIER_PRIORITY_NORMAL
-- end

-- function modifier_monkey_king_tree_dance_lua_arc:PlayEffects()
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