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
modifier_red_transistor_turn = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_red_transistor_turn:IsHidden()
	return false
end

function modifier_red_transistor_turn:IsDebuff()
	return false
end

function modifier_red_transistor_turn:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_red_transistor_turn:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.timescale = self:GetAbility():GetSpecialValueFor( "timescale" )
	self.distmana = self:GetAbility():GetSpecialValueFor( "distance_per_mana" )
	self.manacost = self:GetAbility():GetSpecialValueFor( "manacost_reduction" )
	self.timescale = 0.1

	if not IsServer() then return end
	self.orders = {}

	self.filter = FilterManager:AddExecuteOrderFilter( self.OrderFilter, self )

	-- set duration
	local duration = kv.duration*self.timescale
	self:SetDuration( duration, true )

	-- timescale
	SendToServerConsole( "host_timescale " .. self.timescale )

	-- play effects
	self:PlayEffects1()
end

function modifier_red_transistor_turn:OnRefresh( kv )
	-- references
	self.timescale = self:GetAbility():GetSpecialValueFor( "timescale" )
	self.distmana = self:GetAbility():GetSpecialValueFor( "distance_per_mana" )
	self.manacost = self:GetAbility():GetSpecialValueFor( "manacost_reduction" )
end

function modifier_red_transistor_turn:OnRemoved()
end

function modifier_red_transistor_turn:OnDestroy()
	if not IsServer() then return end
	FilterManager:RemoveExecuteOrderFilter( self.filter )

	SendToServerConsole( "host_timescale 1" )

	local origin = self.parent:GetOrigin()

	for i,order in ipairs(self.orders) do
		self:Execute( order )
	end

	self.parent:SetOrigin( origin )

	-- stop effects
	local sound_cast = "Red_Transistor.Turn.Cast"
	StopGlobalSound( sound_cast )
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_red_transistor_turn:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}

	return funcs
end

function modifier_red_transistor_turn:GetModifierMoveSpeed_Limit()
	if not IsServer() then return 0 end
	return 0.1
end

function modifier_red_transistor_turn:GetModifierPercentageCooldown()
	return 100
end

function modifier_red_transistor_turn:GetModifierPercentageManacost()
	return self.manacost
end

function modifier_red_transistor_turn:GetModifierDisableTurning()
	return 1
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_red_transistor_turn:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Filter
function modifier_red_transistor_turn:OrderFilter( data )
	if #data.units>1 then return true end

	local unit
	for _,id in pairs(data.units) do
		unit = EntIndexToHScript( id )
	end
	if unit~=self.parent then return true end

	if data.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION then
		-- move logic
		self:MoveLogic( data )

		return false
	elseif
		data.order_type==DOTA_UNIT_ORDER_CAST_NO_TARGET or
		data.order_type==DOTA_UNIT_ORDER_CAST_POSITION or
		data.order_type==DOTA_UNIT_ORDER_CAST_TARGET
	then
		-- ability logic
		local ability = EntIndexToHScript( data.entindex_ability )
		if not ability:IsItem() then
			self:AbilityLogic( data )
			return false
		end
	end

	return true
end

function modifier_red_transistor_turn:ShallowCopy( data )
	local ret = {}
	for k,v in pairs(data) do
		ret[k] = v
	end
	return ret
end

function modifier_red_transistor_turn:MoveLogic( data )
	-- get point
	local point = Vector( data.position_x, data.position_y, data.position_z )
	local origin = self.parent:GetOrigin()

	-- calculate dir
	local dir = (point-origin)
	local dist = dir:Length2D()
	dir.z = 0
	dir = dir:Normalized()

	if dist<1 then return end

	-- calculate mana
	local manacost = dist/self.distmana
	local currentmana = self.parent:GetMana()

	if manacost>currentmana then
		manacost = currentmana
		dist = currentmana * self.distmana
	end
	self.parent:SpendMana( manacost, self:GetAbility() )

	-- teleport
	local pos = origin + dist*dir
	FindClearSpaceForUnit( self.parent, pos, true )
	self.parent:SetForwardVector( dir )

	-- dodge projectiles
	ProjectileManager:ProjectileDodge( self.parent )

	-- play effects
	self:PlayEffects2( origin, self.parent:GetOrigin() )
end

function modifier_red_transistor_turn:AbilityLogic( data )
	local unit
	for _,id in pairs(data.units) do
		unit = EntIndexToHScript( id )
	end
	local ability = EntIndexToHScript( data.entindex_ability )

	-- store order
	local order = self:ShallowCopy( data )
	order.origin = self.parent:GetOrigin()
	table.insert( self.orders, order )

	-- use resources
	ability:UseResources( true, false, true )

	-- set facing
	if data.position_x then
		local point = Vector( data.position_x, data.position_y, data.position_z )
		local origin = self.parent:GetOrigin()

		-- calculate dir
		local dir = (point-origin)
		local dist = dir:Length2D()
		dir.z = 0
		dir = dir:Normalized()
		if dist>=1 then
			self.parent:SetForwardVector( dir )
		end
	end

	-- play effects
	self:PlayEffects3( order.origin, self.parent:GetForwardVector() )
end

function modifier_red_transistor_turn:Execute( order )
	local ability = EntIndexToHScript( order.entindex_ability )

	-- set position
	self.parent:SetOrigin( order.origin )

	if order.order_type==DOTA_UNIT_ORDER_CAST_NO_TARGET then
		self.parent:SetCursorTargetingNothing( true )

	elseif order.order_type==DOTA_UNIT_ORDER_CAST_TARGET then
		local target = EntIndexToHScript( data.entindex_target )
		self.parent:SetCursorCastTarget( target )

	elseif order.order_type==DOTA_UNIT_ORDER_CAST_POSITION then
		local point = Vector( order.position_x, order.position_y, order.position_z )
		self.parent:SetCursorPosition( point )
	end

	-- do the ability
	ability:OnSpellStart()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_red_transistor_turn:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/red_transistor_turn_projected.vpcf"
	local sound_cast = "Red_Transistor.Turn.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, Vector(0,0,0) )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 10000, 0, 0 ) )
	ParticleManager:SetParticleFoWProperties( effect_cast, 0, 1, 20000 )

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
	EmitGlobalSound( sound_cast )
end

function modifier_red_transistor_turn:PlayEffects2( origin, target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf"
	local sound_start = "Hero_VoidSpirit.AstralStep.Start"
	local sound_end = "Hero_VoidSpirit.AstralStep.End"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( origin, sound_start, self:GetParent() )
	EmitSoundOnLocationWithCaster( target, sound_end, self:GetParent() )
end

function modifier_red_transistor_turn:PlayEffects3( origin, direction )
	-- Get Resources
	local particle_cast = "particles/red_transistor_turn.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, origin )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0,0,0), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControl( effect_cast, 4, Vector( 1.1, 0, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 5, origin )
	ParticleManager:SetParticleControlForward( effect_cast, 0, direction )

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