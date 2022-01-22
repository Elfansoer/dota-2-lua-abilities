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
modifier_pudge_meat_hook_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_pudge_meat_hook_lua:IsHidden()
	return false
end

function modifier_pudge_meat_hook_lua:IsDebuff()
	return self.enemy
end

function modifier_pudge_meat_hook_lua:IsStunDebuff()
	return true
end

function modifier_pudge_meat_hook_lua:IsPurgable()
	return true
end

-- Optional Classifications
function modifier_pudge_meat_hook_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_pudge_meat_hook_lua:RemoveOnDeath()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_pudge_meat_hook_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.offset = 80
	self.threshold = 80
	self.speed = self:GetAbility():GetSpecialValueFor( "hook_speed" )

	if not IsServer() then return end

	-- get position data
	self.data = self.ability.projectiles[kv.handle]
	if not self.data then
		self.failed = true
		self:Destroy()
		return
	end
	self.origin = self.data.cast_location

	-- remove ref
	self.ability.projectiles[kv.handle] = nil

	-- get additional data
	self.enemy = self.parent:GetTeamNumber()~=self.caster:GetTeamNumber()
	self.stunned = self.enemy and (not self.parent:IsMagicImmune())
	self.interrupted = false

	-- calculate direction
	self.direction = self.origin - self.parent:GetOrigin()
	self.direction.z = 0

	self.distance = self.direction:Length2D() - self.offset
	self.direction = self.direction:Normalized()

	-- calculate duration
	self.duration = self.distance/self.speed
	self:SetDuration(self.duration,true)

	-- set facing direction
	self.parent:SetForwardVector( self.direction )

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:GetParent():RemoveHorizontalMotionController( self )
	end

end

function modifier_pudge_meat_hook_lua:OnRefresh( kv )
end

function modifier_pudge_meat_hook_lua:OnRemoved()
end

function modifier_pudge_meat_hook_lua:OnDestroy()
	if not IsServer() then return end
	if self.failed then return end

	-- remove particle ref
	ParticleManager:DestroyParticle( self.data.effect_cast, true )
	ParticleManager:ReleaseParticleIndex( self.data.effect_cast )

	if not self.interrupted then
		self:GetParent():RemoveHorizontalMotionController( self )
	end

	-- force parent to the cast location
	FindClearSpaceForUnit( self.parent, self.origin - self.direction * self.offset, true )

	-- play effects
	EmitSoundOn( "Hero_Pudge.AttackHookRetractStop", self.caster )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_pudge_meat_hook_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_pudge_meat_hook_lua:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_pudge_meat_hook_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stunned,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_pudge_meat_hook_lua:UpdateHorizontalMotion( me, dt )
	if self.interrupted then return end

	local nextpos = me:GetOrigin() + self.direction * self.speed * dt
	nextpos = GetGroundPosition( nextpos, me )
	me:SetOrigin( nextpos )

	-- check caster still in cast position
	if (self.caster:GetOrigin()-self.origin):Length2D() > self.threshold then
		-- set effects
		ParticleManager:SetParticleControlEnt(
			self.data.effect_cast,
			0,
			self:GetCaster(),
			PATTACH_WORLDORIGIN,
			"attach_hitloc",
			self.origin, -- unknown
			true -- unknown, true
		)
		ParticleManager:SetParticleControl( self.data.effect_cast, 0, self.origin )
	end
end

function modifier_pudge_meat_hook_lua:OnHorizontalMotionInterrupted()
	-- set effects
	ParticleManager:SetParticleControlEnt(
		self.data.effect_cast,
		0,
		self:GetCaster(),
		PATTACH_WORLDORIGIN,
		"attach_hitloc",
		self.origin, -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		self.data.effect_cast,
		1,
		self:GetCaster(),
		PATTACH_WORLDORIGIN,
		"attach_hitloc",
		self.origin, -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( self.data.effect_cast, 0, self.origin )
	ParticleManager:SetParticleControl( self.data.effect_cast, 1, self.origin )

	self:GetParent():RemoveHorizontalMotionController( self )
	self.interrupted = true
end