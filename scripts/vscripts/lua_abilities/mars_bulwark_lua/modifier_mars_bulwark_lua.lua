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
modifier_mars_bulwark_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_mars_bulwark_lua:IsHidden()
	return false
end

function modifier_mars_bulwark_lua:IsDebuff()
	return false
end

function modifier_mars_bulwark_lua:IsStunDebuff()
	return false
end

function modifier_mars_bulwark_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_mars_bulwark_lua:OnCreated( kv )
	-- references
	self.reduction_front = self:GetAbility():GetSpecialValueFor( "physical_damage_reduction" )
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "physical_damage_reduction_side" )
	self.angle_front = self:GetAbility():GetSpecialValueFor( "forward_angle" )/2
	self.angle_side = self:GetAbility():GetSpecialValueFor( "side_angle" )/2

	if IsServer() then
		self.parent = self:GetParent()
	end
end

function modifier_mars_bulwark_lua:OnRefresh( kv )
	-- references
	self.reduction_front = self:GetAbility():GetSpecialValueFor( "physical_damage_reduction" )
	self.reduction_side = self:GetAbility():GetSpecialValueFor( "physical_damage_reduction_side" )
	self.angle_front = self:GetAbility():GetSpecialValueFor( "forward_angle" )/2
	self.angle_side = self:GetAbility():GetSpecialValueFor( "side_angle" )/2
end

function modifier_mars_bulwark_lua:OnRemoved()
end

function modifier_mars_bulwark_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_mars_bulwark_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}

	return funcs
end

function modifier_mars_bulwark_lua:GetModifierPhysical_ConstantBlock( params )
	-- cancel if from ability
	if params.inflictor then return 0 end

	-- cancel if break
	if params.target:PassivesDisabled() then return 0 end

	-- get data
	local parent = params.target
	local attacker = params.attacker
	local reduction = 0

	-- Check target position
	local facing_direction = parent:GetAnglesAsVector().y
	local attacker_vector = (attacker:GetOrigin() - parent:GetOrigin())
	local attacker_direction = VectorToAngles( attacker_vector ).y
	local angle_diff = math.abs( AngleDiff( facing_direction, attacker_direction ) )

	-- calculate damage reduction
	if angle_diff < self.angle_front then
		reduction = self.reduction_front
		self:PlayEffects( true, attacker_vector )

	elseif angle_diff < self.angle_side then
		reduction = self.reduction_side
		self:PlayEffects( false, attacker_vector )
	end

	return reduction*params.damage/100
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_mars_bulwark_lua:PlayEffects( front )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars.vpcf"
	local sound_cast = "Hero_Mars.Shield.Block"

	if not front then
		particle_cast = "particles/units/heroes/hero_mars/mars_shield_of_mars_small.vpcf"
		sound_cast = "Hero_Mars.Shield.BlockSmall"
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end