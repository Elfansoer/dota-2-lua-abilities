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
modifier_slark_pounce_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_slark_pounce_lua:IsHidden()
	return false
end

function modifier_slark_pounce_lua:IsDebuff()
	return false
end

function modifier_slark_pounce_lua:IsStunDebuff()
	return false
end

function modifier_slark_pounce_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_slark_pounce_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	local speed = self:GetAbility():GetSpecialValueFor( "pounce_speed" )
	local distance = self:GetAbility():GetSpecialValueFor( "pounce_distance" )
	if self.parent:HasScepter() then
		local new_distance = self:GetAbility():GetSpecialValueFor( "pounce_distance_scepter" )
		speed = new_distance/distance*speed
		distance = new_distance
	end
	self.radius = self:GetAbility():GetSpecialValueFor( "pounce_radius" )
	self.leash_radius = self:GetAbility():GetSpecialValueFor( "leash_radius" )
	self.leash_duration = self:GetAbility():GetSpecialValueFor( "leash_duration" )

	local duration = distance/speed
	local height = 160

	if not IsServer() then return end

	-- arc
	self.arc = self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			speed = speed,
			duration = duration,
			distance = distance,
			height = height,
		} -- kv
	)
	self.arc:SetEndCallback(function( interrupted )
		-- destroy this modifier when arc ends
		if self:IsNull() then return end
		self.arc = nil
		self:Destroy()
	end)

	-- set duration
	self:SetDuration( duration, true )

	-- set inactive
	self:GetAbility():SetActivated( false )

	-- Start interval
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()

	-- play effects
	self:PlayEffects()
end

function modifier_slark_pounce_lua:OnRefresh( kv )
end

function modifier_slark_pounce_lua:OnRemoved()
end

function modifier_slark_pounce_lua:OnDestroy()
	if not IsServer() then return end

	-- set active
	self:GetAbility():SetActivated( true )

	-- destroy trees upon land
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), 100, false )

	-- destroy arc modifier
	if self.arc and not self.arc:IsNull() then
		self.arc:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_slark_pounce_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_slark_pounce_lua:OnIntervalThink()
	-- find units
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		FIND_CLOSEST,	-- int, order filter
		false	-- bool, can grow cache
	)

	local target
	for _,enemy in pairs(enemies) do
		if not enemy:IsIllusion() then
			target = enemy
			break
		end
	end
	if not target then return end

	-- add leash
	target:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_slark_pounce_lua_debuff", -- modifier name
		{
			duration = self.leash_duration,
			radius = self.leash_radius,
			purgable = false,
		} -- kv
	)

	-- play effects
	local sound_cast = "Hero_Slark.Pounce.Impact"
	EmitSoundOn( sound_cast, target )

	-- destroy
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_slark_pounce_lua:GetEffectName()
	return "particles/units/heroes/hero_slark/slark_pounce_trail.vpcf"
end

function modifier_slark_pounce_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_slark_pounce_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_slark/slark_pounce_start.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:ReleaseParticleIndex( effect_cast )

end