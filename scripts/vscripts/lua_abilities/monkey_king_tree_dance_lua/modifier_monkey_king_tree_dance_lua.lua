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
	self.flying_delta = 150

	if not IsServer() then return end
	-- get data
	self.parent = self:GetParent()

	self.tree = EntIndexToHScript( kv.tree )
	self.origin = self.tree:GetOrigin()

	if not self:ApplyHorizontalMotionController() then
		self.interrupted = true
		self:Destroy()
	end
	if not self:ApplyVerticalMotionController() then
		self.interrupted = true
		self:Destroy()
	end

	-- Start interval
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
	self:GetParent():InterruptMotionControllers( true )
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

		local pos = params.new_pos
		if params.target then pos = params.target:GetOrigin() end

		-- get direction
		local direction = pos - self.tree:GetOrigin()
		direction.z = 0
		direction = direction:Normalized()

		local flying_delta = 150
		local distance = 150
		local endpos = self.tree:GetOrigin() + direction * distance
		local startpos = self.parent:GetOrigin()

		-- get final position
		-- local height_max = startpos.z - GetGroundHeight( startpos, nil )
		local height_max = 1
		local height_end = GetGroundHeight( endpos, nil )
		height_end = height_end - startpos.z

		-- add jump modifier
		self.parent:AddNewModifier(
			self.parent, -- player source
			self:GetAbility(), -- ability source
			"modifier_monkey_king_tree_dance_lua_arc", -- modifier name
			{
				tree = self.tree:entindex(),
				perch = 1,
				speed = 550,
				height_max = height_max,
				height_end = height_end,
				x = endpos.x,
				y = endpos.y,
				exit = 1,
			} -- kv
		)

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
		[MODIFIER_STATE_FLYING] = true,
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
	self.parent:AddNewModifier(
		self.parent, -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_stunned_lua", -- modifier name
		{ duration = self.stun } -- kv
	)
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_monkey_king_tree_dance_lua:UpdateHorizontalMotion( me, dt )
	me:SetOrigin( self.origin )
end

function modifier_monkey_king_tree_dance_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
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

	pos.z = pos.z + self.perch_height - self.flying_delta

	me:SetOrigin( pos )
end

function modifier_monkey_king_tree_dance_lua:OnVerticalMotionInterrupted()
	self:Destroy()
end