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
modifier_primal_beast_onslaught_lua_charge = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_primal_beast_onslaught_lua_charge:IsHidden()
	return false
end

function modifier_primal_beast_onslaught_lua_charge:IsDebuff()
	return false
end

function modifier_primal_beast_onslaught_lua_charge:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_primal_beast_onslaught_lua_charge:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.speed = self:GetAbility():GetSpecialValueFor( "charge_speed" )
	self.turn_speed = self:GetAbility():GetSpecialValueFor( "turn_rate" )

	if not IsServer() then return end

	self.origin = self.parent:GetOrigin()
	self.charge_finish = false

	-- turning data
	self.target_angle = self.parent:GetAnglesAsVector().y
	self.current_angle = self.target_angle
	self.face_target = true

	-- Start interval
	self:StartIntervalThink( FrameTime() )

	-- order filter using library
	self.filter = FilterManager:AddExecuteOrderFilter( self.OrderFilter, self )

	-- play effect
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_primal_beast_onslaught_lua_charge:OnRefresh( kv )
end

function modifier_primal_beast_onslaught_lua_charge:OnRemoved()
	if not IsServer() then return end

	-- stop effects
	local sound_cast = "Hero_PrimalBeast.Onslaught.Channel"
	EmitSoundOn( sound_cast, self.parent )

	if not self.charge_finish then
		self.ability:OnChargeFinish( false )
	end

	-- remove filter
	FilterManager:RemoveExecuteOrderFilter( self.filter )
end

function modifier_primal_beast_onslaught_lua_charge:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_primal_beast_onslaught_lua_charge:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
	}

	return funcs
end

function modifier_primal_beast_onslaught_lua_charge:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	-- point right click
	if 	params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
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
		self.ability:OnChargeFinish( false )
	end	
end

function modifier_primal_beast_onslaught_lua_charge:SetDirection( location )
	local dir = ((location-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
	self.target_angle = VectorToAngles( dir ).y
	self.face_target = false
end

function modifier_primal_beast_onslaught_lua_charge:GetModifierMoveSpeed_Limit()
	return 0.1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_primal_beast_onslaught_lua_charge:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Filter
-- NOTE: Filter is required because right-clicking faces the unit to target position, RESPECTING the terrain, so the target point may be different
function modifier_primal_beast_onslaught_lua_charge:OrderFilter( data )
	-- only filter right-clicks
	if data.order_type~=DOTA_UNIT_ORDER_MOVE_TO_POSITION and
		data.order_type~=DOTA_UNIT_ORDER_MOVE_TO_TARGET and
		data.order_type~=DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		return true
	end

	-- filter orders given to parent
	local found = false
	for _,entindex in pairs(data.units) do
		local entunit = EntIndexToHScript( entindex )
		if entunit==self.parent then
			found = true
		end
	end
	if not found then return true end

	-- set order to move to direction
	data.order_type = DOTA_UNIT_ORDER_MOVE_TO_DIRECTION

	-- if there is target, set position to its origin
	if data.entindex_target~=0 then
		local pos = EntIndexToHScript( data.entindex_target ):GetOrigin()
		data.position_x = pos.x
		data.position_y = pos.y
		data.position_z = pos.z
	end

	return true
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_primal_beast_onslaught_lua_charge:OnIntervalThink()
	-- cancel logic
	if self.parent:IsRooted() or self.parent:IsStunned() or self.parent:IsSilenced() or
		self.parent:IsCurrentlyHorizontalMotionControlled() or self.parent:IsCurrentlyVerticalMotionControlled()
	then
		self.ability:OnChargeFinish( true )
	end

	-- turning logic
	self:TurnLogic( FrameTime() )

	-- set particles
	self:SetEffects()
end

function modifier_primal_beast_onslaught_lua_charge:TurnLogic( dt )
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

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_primal_beast_onslaught_lua_charge:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_range_finder.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner() )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	self.effect_cast = effect_cast
	self:SetEffects()
end

function modifier_primal_beast_onslaught_lua_charge:SetEffects()
	local target_pos = self.origin + self.parent:GetForwardVector() * self.speed * self:GetElapsedTime()
	ParticleManager:SetParticleControl( self.effect_cast, 1, target_pos )
end

function modifier_primal_beast_onslaught_lua_charge:PlayEffects2()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf"
	local sound_cast = "Hero_PrimalBeast.Onslaught.Channel"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.parent:GetOrigin() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
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

	-- Create Sound
	EmitSoundOn( sound_cast, self.parent )
end
