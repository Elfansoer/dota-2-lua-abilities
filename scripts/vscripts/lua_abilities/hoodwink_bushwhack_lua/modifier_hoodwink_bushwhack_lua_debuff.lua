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
modifier_hoodwink_bushwhack_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_bushwhack_lua_debuff:IsHidden()
	return false
end

function modifier_hoodwink_bushwhack_lua_debuff:IsDebuff()
	return true
end

function modifier_hoodwink_bushwhack_lua_debuff:IsStunDebuff()
	return true
end

function modifier_hoodwink_bushwhack_lua_debuff:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_bushwhack_lua_debuff:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.height = self:GetAbility():GetSpecialValueFor( "visual_height" )
	self.rate = self:GetAbility():GetSpecialValueFor( "animation_rate" )

	self.distance = 150
	self.speed = 900
	self.interval = 0.1

	if not IsServer() then return end
	self.tree = EntIndexToHScript( kv.tree )
	self.tree_origin = self.tree:GetOrigin()

	-- apply motion controller
	if not self:ApplyHorizontalMotionController() then
		-- self:Destroy()
		return
	end

	-- tree cut down thinker
	self:StartIntervalThink( self.interval )

	-- Play Effects
	self:PlayEffects1()
end

function modifier_hoodwink_bushwhack_lua_debuff:OnRefresh( kv )
	self:OnCreated( kv )
end

function modifier_hoodwink_bushwhack_lua_debuff:OnRemoved()
end

function modifier_hoodwink_bushwhack_lua_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )

end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hoodwink_bushwhack_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,

		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
		MODIFIER_PROPERTY_VISUAL_Z_DELTA,
	}

	return funcs
end

function modifier_hoodwink_bushwhack_lua_debuff:GetFixedDayVision()
	return 0
end

function modifier_hoodwink_bushwhack_lua_debuff:GetFixedNightVision()
	return 0
end

function modifier_hoodwink_bushwhack_lua_debuff:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_hoodwink_bushwhack_lua_debuff:GetOverrideAnimationRate()
	return self.rate
end

function modifier_hoodwink_bushwhack_lua_debuff:GetVisualZDelta()
	return self.height
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hoodwink_bushwhack_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hoodwink_bushwhack_lua_debuff:OnIntervalThink()
	-- check if the tree is still standing
	if not self.tree.IsStanding then
		-- temp tree
		if self.tree:IsNull() then
			self:Destroy()
		end

	elseif not self.tree:IsStanding() then
		-- temp tree
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_hoodwink_bushwhack_lua_debuff:UpdateHorizontalMotion( me, dt )
	-- get data
	local origin = me:GetOrigin()
	local dir = self.tree_origin-origin
	local dist = dir:Length2D()
	dir.z = 0
	dir = dir:Normalized()

	-- check if close
	if dist<self.distance then
		self:GetParent():RemoveHorizontalMotionController( self )

		self:PlayEffects2( dir )

		return
	end

	-- move closer to tree
	local target = dir * self.speed*dt
	me:SetOrigin( origin + target )
end

function modifier_hoodwink_bushwhack_lua_debuff:OnHorizontalMotionInterrupted()
	self:GetParent():RemoveHorizontalMotionController( self )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hoodwink_bushwhack_lua_debuff:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_bushwhack_target.vpcf"
	local sound_cast = "Hero_Hoodwink.Bushwhack.Target"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 15, self.tree_origin )

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

function modifier_hoodwink_bushwhack_lua_debuff:PlayEffects2( dir )
	-- Get Resources
	local particle_cast = "particles/tree_fx/tree_simple_explosion.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end