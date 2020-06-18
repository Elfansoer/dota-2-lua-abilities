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
modifier_monkey_king_tree_dance_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_monkey_king_tree_dance_lua:IsHidden()
	return false
end

function modifier_monkey_king_tree_dance_lua:IsDebuff()
	return false
end

function modifier_monkey_king_tree_dance_lua:IsStunDebuff()
	return false
end

function modifier_monkey_king_tree_dance_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_monkey_king_tree_dance_lua:OnCreated( kv )
	-- references
	self.perch_height = self:GetAbility():GetSpecialValueFor( "perched_spot_height" )
	self.dayvision = self:GetAbility():GetSpecialValueFor( "perched_day_vision" )
	self.nightvision = self:GetAbility():GetSpecialValueFor( "perched_night_vision" )
	self.stun = self:GetAbility():GetSpecialValueFor( "unperched_stunned_duration" )

	-- reference above is fake news
	self.perch_height = 256

	if not IsServer() then return end
	-- get data
	self.parent = self:GetParent()
	self.tree = EntIndexToHScript( kv.tree )
	self.origin = self.tree:GetOrigin()

	-- apply still motion
	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
	if not self:ApplyVerticalMotionController() then
		self.interrupted = true
		self:Destroy()
	end

	-- set spring ability as active
	self.spring = self:GetCaster():FindAbilityByName( 'monkey_king_primal_spring_lua' )
	if self.spring then
		self.spring:SetActivated( true )
	end

	-- Start interval check for tree cur
	self:StartIntervalThink( 0.1 )
	self:OnIntervalThink()

	-- play effects
	local sound_cast = "Hero_MonkeyKing.TreeJump.Tree"
	EmitSoundOn( sound_cast, self.parent )
end

function modifier_monkey_king_tree_dance_lua:OnRefresh( kv )
	
end

function modifier_monkey_king_tree_dance_lua:OnRemoved()
end

function modifier_monkey_king_tree_dance_lua:OnDestroy()
	if not IsServer() then return end

	-- set spring ability as inactive
	if self.spring then
		self.spring:SetActivated( false )
	end

	-- preserve height
	local pos = self:GetParent():GetOrigin()

	self:GetParent():RemoveHorizontalMotionController( self )
	self:GetParent():RemoveVerticalMotionController( self )

	-- preserve height
	if not self.unperched then
		self:GetParent():SetOrigin( pos )
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_monkey_king_tree_dance_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ORDER,

		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION,
	}

	return funcs
end

function modifier_monkey_king_tree_dance_lua:OnOrder( params )
	if params.unit~=self.parent then return end

	-- right click, switch position
	if params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
		params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
		params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
	then
		-- dont do anything if on cooldown
		if not self:GetAbility():IsCooldownReady() then
			local order = {
				UnitIndex = self.parent:entindex(),
				OrderType = DOTA_UNIT_ORDER_STOP,
			}
			ExecuteOrderFromTable( order )
			return
		end

		-- don't do anything if casting primal spring
		if self.spring and self.spring:IsChanneling() then return end

		-- get target
		local pos = params.new_pos
		if params.target then pos = params.target:GetOrigin() end
		local direction = (pos-self.parent:GetOrigin())
		direction.z = 0
		direction = direction:Normalized()

		-- set facing
		self.parent:SetForwardVector( direction )

		-- jump arc
		local arc = self.parent:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_generic_arc_lua", -- modifier name
			{
				dir_x = direction.x,
				dir_y = direction.y,
				distance = 150,
				speed = 550,
				height = 1,
				start_offset = self.perch_height,
				fix_end = false,
				isForward = true,
			} -- kv
		)
		arc:SetEndCallback(function()
			-- find clear space
			FindClearSpaceForUnit( self.parent, self.parent:GetOrigin(), true )
		end)

		-- play effects
		self:PlayEffects( arc )

		-- self destroy
		self:Destroy()
	end
end

function modifier_monkey_king_tree_dance_lua:GetFixedDayVision()
	return self.dayvision
end

function modifier_monkey_king_tree_dance_lua:GetFixedNightVision()
	return self.nightvision
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_monkey_king_tree_dance_lua:CheckState()
	local state = {
		-- [MODIFIER_STATE_FLYING] = true,
		-- [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_monkey_king_tree_dance_lua:OnIntervalThink()
	-- temp tree
	if not self.tree.IsStanding then
		if self.tree:IsNull() then
			self:Destroy()
		end
		return
	end

	-- check if the tree is still standing
	if self.tree:IsStanding() then return end

	-- destroy modifier and stun
	local mod = self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.stun } -- kv
	)

	-- add tag
	self.unperched = true

	self:Destroy()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_monkey_king_tree_dance_lua:UpdateHorizontalMotion( me, dt )
	me:SetOrigin( self.origin )
end

function modifier_monkey_king_tree_dance_lua:UpdateVerticalMotion( me, dt )
	-- if temp tree destroyed, destroy
	if not self.tree.IsStanding then
		if self.tree:IsNull() then
			self:Destroy()
		end
		return
	end

	local pos = self.tree:GetOrigin()
	pos.z = pos.z + self.perch_height

	me:SetOrigin( pos )
end

function modifier_monkey_king_tree_dance_lua:OnVerticalMotionInterrupted()
	self:Destroy()
end

function modifier_monkey_king_tree_dance_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_monkey_king_tree_dance_lua:PlayEffects( modifier )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )

	-- buff particle
	modifier:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end