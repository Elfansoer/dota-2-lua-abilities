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
modifier_primal_beast_onslaught_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_onslaught_lua:IsHidden()
	return false
end

function modifier_primal_beast_onslaught_lua:IsDebuff()
	return false
end

function modifier_primal_beast_onslaught_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_onslaught_lua:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.speed = self:GetAbility():GetSpecialValueFor( "charge_speed" )
	self.turn_speed = self:GetAbility():GetSpecialValueFor( "turn_rate" )

	self.radius = self:GetAbility():GetSpecialValueFor( "knockback_radius" )
	self.distance = self:GetAbility():GetSpecialValueFor( "knockback_distance" )
	self.duration = self:GetAbility():GetSpecialValueFor( "knockback_duration" )
	self.stun = self:GetAbility():GetSpecialValueFor( "stun_duration" )
	local damage = self:GetAbility():GetSpecialValueFor( "knockback_damage" )

	self.tree_radius = 100
	self.height = 50
	self.duration = 0.3 -- kv above is a lie

	if not IsServer() then return end

	-- ability properties
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	-- turning data
	self.target_angle = self.parent:GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true

	-- knockback data
	self.knockback_units = {}
	self.knockback_units[self.parent] = true

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.parent,
		damage = damage,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
	}
end

function modifier_primal_beast_onslaught_lua:OnRefresh( kv )
end

function modifier_primal_beast_onslaught_lua:OnRemoved()
end

function modifier_primal_beast_onslaught_lua:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), false )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_onslaught_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_DISABLE_TURNING,

		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
	}

	return funcs
end

function modifier_primal_beast_onslaught_lua:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	-- point right click
	if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		ExecuteOrderFromTable({
			UnitIndex = self.parent:entindex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_DIRECTION,
			Position = params.new_pos,
		})
	elseif
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
	then
		-- set facing
		self:SetDirection( params.new_pos )

	-- targetted right click
	elseif 
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		-- set facing
		self:SetDirection( params.target:GetOrigin() )
	
	elseif
		params.order_type==DOTA_UNIT_ORDER_STOP or 
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end	
end

function modifier_primal_beast_onslaught_lua:GetModifierDisableTurning()
	return 1
end

function modifier_primal_beast_onslaught_lua:SetDirection( location )
	local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_primal_beast_onslaught_lua:GetOverrideAnimation()
	return ACT_DOTA_RUN
end

function modifier_primal_beast_onslaught_lua:GetActivityTranslationModifiers()
	return "onslaught_movement"
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_primal_beast_onslaught_lua:OnIntervalThink()
end

function modifier_primal_beast_onslaught_lua:TurnLogic( dt )
	-- only rotate when target changed
	if self.face_target then return end

	local angle_diff = AngleDiff( self.current_angle, self.target_angle )
	local turn_speed = self.turn_speed*dt

	local sign = -1
	if angle_diff<0 then sign = 1 end

	if math.abs( angle_diff )<1.1*turn_speed then
		-- end rotating
		self.current_angle = self.target_angle
		self.face_target = true
	else
		-- rotate current angle
		self.current_angle = self.current_angle + sign*turn_speed
	end

	-- turn the unit
	local angles = self.parent:GetAnglesAsVector()
	self.parent:SetLocalAngles( angles.x, self.current_angle, angles.z )
end

function modifier_primal_beast_onslaught_lua:HitLogic()
	-- destroy trees
	GridNav:DestroyTreesAroundPoint( self.parent:GetOrigin(), self.tree_radius, false )

	local units = FindUnitsInRadius(
		self.parent:GetTeamNumber(),	-- int, your team number
		self.parent:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_BOTH,	-- int, team filter
		self.abilityTargetType,	-- int, type filter
		self.abilityTargetFlags,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,unit in pairs(units) do
		-- only knockback once
		if not self.knockback_units[unit] then
			self.knockback_units[unit] = true

			local is_enemy = unit:GetTeamNumber()~=self.parent:GetTeamNumber()

			-- damage and stun
			if is_enemy then
				local enemy = unit

				-- damage
				self.damageTable.victim = enemy
				ApplyDamage(self.damageTable)

				-- stun
				enemy:AddNewModifier(
					self.parent, -- player source
					self.ability, -- ability source
					"modifier_generic_stunned_lua", -- modifier name
					{ duration = self.stun } -- kv
				)
			end

			-- knockback, for both enemies and allies
			if is_enemy or not (unit:IsCurrentlyHorizontalMotionControlled() or unit:IsCurrentlyVerticalMotionControlled()) then
				-- knockback data
				local direction = unit:GetOrigin()-self.parent:GetOrigin()
				direction.z = 0
				direction = direction:Normalized()

				-- create arc
				unit:AddNewModifier(
					self.parent, -- player source
					self.ability, -- ability source
					"modifier_generic_arc_lua", -- modifier name
					{
						dir_x = direction.x,
						dir_y = direction.y,
						duration = self.duration,
						distance = self.distance,
						height = self.height,
						activity = ACT_DOTA_FLAIL,
					} -- kv
				)
			end

			-- play effects
			self:PlayEffects( unit, self.radius )
		end
	end
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_primal_beast_onslaught_lua:UpdateHorizontalMotion( me, dt )
	-- cancel if rooted
	if self.parent:IsRooted() then
		self:Destroy()
		return
	end

	self:HitLogic()

	self:TurnLogic( dt )

	local nextpos = me:GetOrigin() + me:GetForwardVector() * self.speed * dt
	me:SetOrigin(nextpos)
end

function modifier_primal_beast_onslaught_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_primal_beast_onslaught_lua:GetEffectName()
	return "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
end

function modifier_primal_beast_onslaught_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_primal_beast_onslaught_lua:PlayEffects( target, radius )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf"
	local sound_cast = "Hero_PrimalBeast.Onslaught.Hit"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, target )
end


