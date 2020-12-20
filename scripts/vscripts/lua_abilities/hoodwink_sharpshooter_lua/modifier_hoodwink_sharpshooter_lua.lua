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
modifier_hoodwink_sharpshooter_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_hoodwink_sharpshooter_lua:IsHidden()
	return false
end

function modifier_hoodwink_sharpshooter_lua:IsDebuff()
	return false
end

function modifier_hoodwink_sharpshooter_lua:IsStunDebuff()
	return false
end

function modifier_hoodwink_sharpshooter_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_hoodwink_sharpshooter_lua:OnCreated( kv )
	-- references
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.team = self.parent:GetTeamNumber()

	self.charge = self:GetAbility():GetSpecialValueFor( "max_charge_time" )
	self.damage = self:GetAbility():GetSpecialValueFor( "max_damage" )
	self.duration = self:GetAbility():GetSpecialValueFor( "max_slow_debuff_duration" )
	self.turn_rate = self:GetAbility():GetSpecialValueFor( "turn_rate" )

	self.recoil_distance = self:GetAbility():GetSpecialValueFor( "recoil_distance" )
	self.recoil_duration = self:GetAbility():GetSpecialValueFor( "recoil_duration" )
	self.recoil_height = self:GetAbility():GetSpecialValueFor( "recoil_height" )

	-- set interval on both cl and sv
	self.interval = 0.03 
	self:StartIntervalThink( self.interval )

	if not IsServer() then return end

	-- references
	self.projectile_speed = self:GetAbility():GetSpecialValueFor( "arrow_speed" )
	self.projectile_range = self:GetAbility():GetSpecialValueFor( "arrow_range" )
	self.projectile_width = self:GetAbility():GetSpecialValueFor( "arrow_width" )
	local projectile_vision = self:GetAbility():GetSpecialValueFor( "arrow_vision" )
	local projectile_name = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf"

	-- init turn logic
	local vec = Vector( kv.x, kv.y, 0 )
	self:SetDirection( vec )
	self.current_dir = self.target_dir
	self.face_target = true
	self.parent:SetForwardVector( self.current_dir )
	self.turn_speed = self.interval*self.turn_rate

	-- precache projectile
	self.info = {
		Source = self.parent,
		Ability = self:GetAbility(),
		-- vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = true,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO,

	    EffectName = projectile_name,
	    fDistance = self.projectile_range,
	    fStartRadius = self.projectile_width,
	    fEndRadius = self.projectile_width,
		-- vVelocity = projectile_direction * projectile_speed,
	
		bHasFrontalCone = false,
		bReplaceExisting = false,
		
		bProvidesVision = true,
		iVisionRadius = projectile_vision,
		iVisionTeamNumber = self.caster:GetTeamNumber()
	}

	-- create order filter using library
	self.filter = FilterManager:AddExecuteOrderFilter( self.OrderFilter, self )

	-- swap abilities
	self.caster:SwapAbilities( "hoodwink_sharpshooter_lua", "hoodwink_sharpshooter_release_lua", false, true )

	-- play effects
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_hoodwink_sharpshooter_lua:OnRefresh( kv )
	
end

function modifier_hoodwink_sharpshooter_lua:OnRemoved()
end

function modifier_hoodwink_sharpshooter_lua:OnDestroy()
	if not IsServer() then return end

	-- calculate direction
	local direction = self.current_dir

	-- calculate percentage
	local pct = math.min( self:GetElapsedTime(), self.charge )/self.charge

	-- Launch projectile
	self.info.vSpawnOrigin = self.parent:GetOrigin()
	self.info.vVelocity = direction * self.projectile_speed

	self.info.ExtraData = {
		damage = self.damage * pct,
		duration = self.duration * pct,
		x = direction.x,
		y = direction.y
	}

	ProjectileManager:CreateLinearProjectile( self.info )

	-- knockback
	local mod = self.caster:AddNewModifier(
		self.caster, -- player source
		self, -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			duration = self.recoil_duration,
			height = self.recoil_height,
			distance = self.recoil_distance,
			direction_x = -direction.x,
			direction_y = -direction.y,
		} -- kv
	)

	-- swap abilities
	self.caster:SwapAbilities( "hoodwink_sharpshooter_lua", "hoodwink_sharpshooter_release_lua", true, false )

	-- Remove filter from library
	FilterManager:RemoveExecuteOrderFilter( self.filter )

	-- play effects
	self:PlayEffects4( mod )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_hoodwink_sharpshooter_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,
		
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		-- MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
	}

	return funcs
end

function modifier_hoodwink_sharpshooter_lua:OnOrder( params )
	if params.unit~=self:GetParent() then return end

	if
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
	then
		self:SetDirection( params.new_pos )

	-- stop or hold
	elseif 
		params.order_type==DOTA_UNIT_ORDER_STOP or
		params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION
	then
		self:Destroy()
	end
end

function modifier_hoodwink_sharpshooter_lua:GetModifierMoveSpeed_Limit()
	return 0.1
end

function modifier_hoodwink_sharpshooter_lua:GetModifierTurnRate_Percentage()
	return -self.turn_rate
end

function modifier_hoodwink_sharpshooter_lua:GetModifierDisableTurning()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_hoodwink_sharpshooter_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_hoodwink_sharpshooter_lua:OnIntervalThink()
	if not IsServer() then
		-- client only code
		self:UpdateStack()
		return
	end

	-- turning logic
	self:TurnLogic()

	-- vision
	-- NOTE: Can be optimized if there's a way to move vision provider dynamically
	local startpos = self.parent:GetOrigin()
	local visions = self.projectile_range/self.projectile_width
	local delta = self.parent:GetForwardVector() * self.projectile_width
	for i=1,visions do
		AddFOWViewer( self.team, startpos, self.projectile_width, 0.1, false )
		startpos = startpos + delta
	end

	-- max charge sound
	if not self.charged and self:GetElapsedTime()>self.charge then
		self.charged = true

		-- play effects
		local sound_cast = "Hero_Hoodwink.Sharpshooter.MaxCharge"
		EmitSoundOnClient( sound_cast, self.parent:GetPlayerOwner() )
	end

	-- timer particle
	local remaining = self:GetRemainingTime()
	local seconds = math.ceil( remaining )
	local isHalf = (seconds-remaining)>0.5
	if isHalf then seconds = seconds-1 end

	if self.half~=isHalf then
		self.half = isHalf

		-- play effects
		self:PlayEffects3( seconds, isHalf )
	end

	-- update paticle
	self:UpdateEffect()
end

--------------------------------------------------------------------------------
-- Helper
function modifier_hoodwink_sharpshooter_lua:SetDirection( vec )
	self.target_dir = ((vec-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
	self.face_target = false
end

function modifier_hoodwink_sharpshooter_lua:TurnLogic()
	-- only rotate when target changed
	if self.face_target then return end

	local current_angle = VectorToAngles( self.current_dir ).y
	local target_angle = VectorToAngles( self.target_dir ).y
	local angle_diff = AngleDiff( current_angle, target_angle )

	local sign = -1
	if angle_diff<0 then sign = 1 end

	-- end rotating
	if math.abs( angle_diff )<1.1*self.turn_speed then
		self.face_target = true
		return
	end

	-- rotate
	self.current_dir = RotatePosition( Vector(0,0,0), QAngle(0, sign*self.turn_speed, 0), self.current_dir )

	-- set facing when not motion controlled
	local a = self.parent:IsCurrentlyHorizontalMotionControlled()
	local b = self.parent:IsCurrentlyVerticalMotionControlled()
	if not (a or b) then
		self.parent:SetForwardVector( self.current_dir )
	end
end

function modifier_hoodwink_sharpshooter_lua:UpdateStack()
	-- only update stack percentage on client to reduce traffic
	local pct = math.min( self:GetElapsedTime(), self.charge )/self.charge
	pct = math.floor( pct*100 )
	self:SetStackCount( pct )
end

--------------------------------------------------------------------------------
-- Filter
function modifier_hoodwink_sharpshooter_lua:OrderFilter( data )
	if #data.units>1 then return true end

	local unit
	for _,id in pairs(data.units) do
		unit = EntIndexToHScript( id )
	end
	if unit~=self.parent then return true end

	if data.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		data.order_type = DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
	elseif data.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET or data.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET then
		local pos = EntIndexToHScript( data.entindex_target ):GetOrigin()

		data.order_type = DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
		data.position_x = pos.x
		data.position_y = pos.y
		data.position_z = pos.z
	end

	return true
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_hoodwink_sharpshooter_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter.vpcf"
	local sound_cast = "Hero_Hoodwink.Sharpshooter.Channel"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetOrigin(), -- unknown
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

function modifier_hoodwink_sharpshooter_lua:PlayEffects2()
	--NOTE: This could be a client-only code to reduce traffic, if only GetForwardVector is available on client. (Why GetAbsOrigin is available but not GetForwardVector?)

	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_range_finder.vpcf"

	-- Get Data
	local startpos = self.parent:GetAbsOrigin()
	local endpos = startpos + self.parent:GetForwardVector() * self.projectile_range

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticleForPlayer( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent, self.parent:GetPlayerOwner() )
	ParticleManager:SetParticleControl( effect_cast, 0, startpos )
	ParticleManager:SetParticleControl( effect_cast, 1, endpos )

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
end

function modifier_hoodwink_sharpshooter_lua:PlayEffects3( seconds, half )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_timer.vpcf"

	-- calculate data
	local mid = 1
	if half then mid = 8 end

	local len = 2
	if seconds<1 then
		len = 1
		if not half then return end
	end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, seconds, mid ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( len, 0, 0 ) )
end

function modifier_hoodwink_sharpshooter_lua:PlayEffects4( modifier )
	-- Get Resources
	local particle_cast = "particles/items_fx/force_staff.vpcf"
	local sound_channel = "Hero_Hoodwink.Sharpshooter.Channel"
	local sound_cast = "Hero_Hoodwink.Sharpshooter.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent )

	-- buff particle
	modifier:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- sound
	StopSoundOn( sound_channel, self.caster )
	EmitSoundOn( sound_cast, self.caster )
end

function modifier_hoodwink_sharpshooter_lua:UpdateEffect()
	--NOTE: This could be a client-only code to reduce traffic, if only GetForwardVector is available on client. (Why GetAbsOrigin is available but not GetForwardVector?)

	-- Get Data
	local startpos = self.parent:GetAbsOrigin()
	local endpos = startpos + self.current_dir * self.projectile_range

	ParticleManager:SetParticleControl( self.effect_cast, 0, startpos )
	ParticleManager:SetParticleControl( self.effect_cast, 1, endpos )
end