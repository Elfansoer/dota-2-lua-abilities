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
modifier_medusa_stone_gaze_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_medusa_stone_gaze_lua_debuff:IsHidden()
	return false
end

function modifier_medusa_stone_gaze_lua_debuff:IsDebuff()
	return true
end

function modifier_medusa_stone_gaze_lua_debuff:IsStunDebuff()
	return false
end

function modifier_medusa_stone_gaze_lua_debuff:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_medusa_stone_gaze_lua_debuff:OnCreated( kv )
	-- references
	self.slow = -self:GetAbility():GetSpecialValueFor( "slow" )
	self.stun_duration = self:GetAbility():GetSpecialValueFor( "stone_duration" )
	self.face_duration = self:GetAbility():GetSpecialValueFor( "face_duration" )
	self.physical_bonus = self:GetAbility():GetSpecialValueFor( "bonus_physical_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	self.stone_angle = self:GetAbility():GetSpecialValueFor( "vision_cone" )
	self.stone_angle = 85 -- why 0.08715???

	self.parent = self:GetParent()
	self.facing = false
	self.counter = 0
	self.interval = 0.03

	if not IsServer() then return end
	self.center_unit = EntIndexToHScript( kv.center_unit )

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2()

	-- Start interval
	self:StartIntervalThink( self.interval )
	self:OnIntervalThink()
end

function modifier_medusa_stone_gaze_lua_debuff:OnRefresh( kv )
	
end

function modifier_medusa_stone_gaze_lua_debuff:OnRemoved()
end

function modifier_medusa_stone_gaze_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_medusa_stone_gaze_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_medusa_stone_gaze_lua_debuff:GetModifierMoveSpeedBonus_Percentage()
	if self.facing then
		return self.slow
	end
end
function modifier_medusa_stone_gaze_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	if self.facing then
		return self.slow
	end
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_medusa_stone_gaze_lua_debuff:OnIntervalThink()
	-- check facing and distance
	local vector = self.center_unit:GetOrigin()-self.parent:GetOrigin()

	local center_angle = VectorToAngles( vector ).y
	local facing_angle = VectorToAngles( self.parent:GetForwardVector() ).y
	local distance = vector:Length2D()

	local prev_facing = self.facing

	-- determine facing
	self.facing = ( math.abs( AngleDiff(center_angle,facing_angle) ) < self.stone_angle ) and (distance < self.radius )

	-- change effects only when the state changed
	if self.facing~=prev_facing then
		self:ChangeEffects( self.facing )
	end

	-- if facing and distance is less than radius, add to counter
	if self.facing then
		self.counter = self.counter + self.interval
	end

	-- if counter is more than face duration, stun and destroy
	if self.counter>=self.face_duration then
		self.parent:AddNewModifier(
			self:GetCaster(), -- player source
			self:GetAbility(), -- ability source
			"modifier_medusa_stone_gaze_lua_petrified", -- modifier name
			{
				duration = self.stun_duration,
				physical_bonus = self.physical_bonus,
				center_unit = self.center_unit:entindex(),
			} -- kv
		)

		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_medusa_stone_gaze_lua_debuff:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_stone_gaze_debuff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.center_unit,
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
function modifier_medusa_stone_gaze_lua_debuff:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_medusa/medusa_stone_gaze_facing.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		self:GetParent(),
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
end

function modifier_medusa_stone_gaze_lua_debuff:ChangeEffects( IsNowFacing )
	-- change cp based on facing or not
	local target = self.parent
	if IsNowFacing then
		target = self.center_unit

		-- play sound
		local sound_cast = "Hero_Medusa.StoneGaze.Target"
		EmitSoundOnClient( sound_cast, self:GetParent():GetPlayerOwner() )
	end

	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
end