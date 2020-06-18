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
modifier_tiny_toss_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_tiny_toss_lua:IsHidden()
	return true
end

function modifier_tiny_toss_lua:IsDebuff()
	return self:GetCaster():GetTeamNumber()~=self:GetParent():GetTeamNumber()
end

function modifier_tiny_toss_lua:IsStunDebuff()
	return true
end

function modifier_tiny_toss_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_tiny_toss_lua:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	-- references
	self.damage = self:GetAbility():GetSpecialValueFor( "toss_damage" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )

	if not IsServer() then return end
	local duration = self:GetAbility():GetSpecialValueFor( "duration" )
	self.target = EntIndexToHScript( kv.target )
	local height = 850

	-- add arc modifier for vertical only
	self.arc = self.parent:AddNewModifier(
		self.caster, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_arc_lua", -- modifier name
		{
			duration = duration,
			distance = 0,
			height = height,
			-- fix_end = true,
			fix_duration = false,
			isStun = true,
			activity = ACT_DOTA_FLAIL,
		} -- kv
	)
	self.arc:SetEndCallback(function( interrupted )
		-- destroy this modifier
		self:Destroy()

		-- not damage if interrupted
		if interrupted then return end

		-- find units
		local enemies = FindUnitsInRadius(
			self.caster:GetTeamNumber(),	-- int, your team number
			self.parent:GetOrigin(),	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			0,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
		)

		-- precache damage
		local damageTable = {
			-- victim = target,
			attacker = self.caster,
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}

		-- damage
		for _,enemy in pairs(enemies) do
			-- damage
			damageTable.victim = enemy
			if enemy==self.parent then
				damageTable.damage = 2*self.damage
			else
				damageTable.damage = self.damage
			end
			ApplyDamage(damageTable)
		end

		-- destroy trees
		GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.radius, false )


		-- play effects
		local sound_cast = "Ability.TossImpact"
		EmitSoundOn( sound_cast, self.parent )
	end)

	-- prepare horizontal motion
	local origin = self.target:GetOrigin()
	local direction = origin-self.parent:GetOrigin()
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()

	-- init speed
	self.distance = distance
	if self.distance==0 then self.distance = 1 end
	self.duration = duration
	self.speed = distance/duration
	self.accel = 100
	self.max_speed = 3000

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end

	-- emit sound
	local sound_cast = "Ability.TossThrow"
	local sound_target = "Hero_Tiny.Toss.Target"
	EmitSoundOn( sound_cast, self.caster )
	EmitSoundOn( sound_target, self.parent )
end

function modifier_tiny_toss_lua:OnRefresh( kv )
	
end

function modifier_tiny_toss_lua:OnRemoved()
end

function modifier_tiny_toss_lua:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveHorizontalMotionController( self )
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_tiny_toss_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_tiny_toss_lua:UpdateHorizontalMotion( me, dt )
	local target = self.target:GetOrigin()
	local parent = self.parent:GetOrigin()

	-- get current states
	local duration = self:GetElapsedTime()
	local direction = target-parent
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()

	-- change speed if target farther/closer
	local original_distance = duration/self.duration * self.distance
	local expected_speed
	if self:GetElapsedTime()>=self.duration then
		expected_speed = self.speed
	else
		expected_speed = distance/(self.duration-self:GetElapsedTime())
	end

	-- accel/deccel speed
	if self.speed<expected_speed then
		self.speed = math.min(self.speed + self.accel, self.max_speed)
	elseif self.speed>expected_speed then
		self.speed = math.max(self.speed - self.accel, 0)
	end

	-- set relative position
	local pos = parent + direction * self.speed * dt
	me:SetOrigin( pos )
end

function modifier_tiny_toss_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_tiny_toss_lua:GetEffectName()
	return "particles/units/heroes/hero_tiny/tiny_toss_blur.vpcf"
end

function modifier_tiny_toss_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end