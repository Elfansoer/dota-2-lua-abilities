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
modifier_windranger_focus_fire_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_windranger_focus_fire_lua:IsHidden()
	return false
end

function modifier_windranger_focus_fire_lua:IsDebuff()
	return false
end

function modifier_windranger_focus_fire_lua:IsPurgable()
	return false
end

function modifier_windranger_focus_fire_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_windranger_focus_fire_lua:OnCreated( kv )
	if not IsServer() then return end
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "focusfire_damage_reduction" )

	self.target = EntIndexToHScript( kv.target )

	self:StartIntervalThink( 0.05 )
	self:OnIntervalThink()
end

function modifier_windranger_focus_fire_lua:OnRefresh( kv )
	if not IsServer() then return end
	-- references
	self.bonus = self:GetAbility():GetSpecialValueFor( "bonus_attack_speed" )
	self.reduction = self:GetAbility():GetSpecialValueFor( "focusfire_damage_reduction" )
end

function modifier_windranger_focus_fire_lua:OnRemoved()
end

function modifier_windranger_focus_fire_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_windranger_focus_fire_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,

		MODIFIER_EVENT_ON_ORDER,
	}

	return funcs
end

function modifier_windranger_focus_fire_lua:GetModifierAttackSpeedBonus_Constant()
	if not IsServer() then return end
	local aggro = self:GetParent():GetAggroTarget()
	if aggro and aggro~=self.target then return end

	return self.bonus
end
function modifier_windranger_focus_fire_lua:GetModifierDamageOutgoing_Percentage()
	if not IsServer() then return end
	local aggro = self:GetParent():GetAggroTarget()
	if aggro and aggro~=self.target then return end

	return self.reduction
end

function modifier_windranger_focus_fire_lua:OnOrder( params )
	if not IsServer() then return end
	if params.unit~=self:GetParent() then return end

	-- if ordered to attack target, move to target instead
	if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target==self.target then
		-- chase instead
		self.follow = true
	else
		self.follow = false
	end

	-- specific order to stop autoattack
	if params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET and params.target~=self.target then
		self.attacking = false
	elseif params.order_type==DOTA_UNIT_ORDER_HOLD_POSITION then
		self.attacking = false
	elseif params.order_type==DOTA_UNIT_ORDER_CONTINUE then
		self.attacking = false
	elseif params.order_type==DOTA_UNIT_ORDER_STOP then
		self.attacking = false
	elseif params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION then
		self.attacking = false

	-- other order resumes attack
	else
		self.attacking = true
	end
end
--------------------------------------------------------------------------------
-- Interval Effects
function modifier_windranger_focus_fire_lua:OnIntervalThink()
	if self.target:IsNull() then
		-- if dead and not respawn, just stop
		self:StartIntervalThink(-1)
		return
	end

	-- check target within range
	local distance = (self.target:GetOrigin()-self:GetParent():GetOrigin()):Length2D()
	local range = self:GetParent():Script_GetAttackRange(  )

	self.inRange = distance<=range

	if self.inRange and self.attacking and self.target:IsAlive() then
		if self.follow then
			-- TODO: not immediately follow target
			self:GetParent():MoveToNPC( self.target )
		end

		-- bombard target, but respect attack speed cooldown
		self:GetParent():PerformAttack(
			self.target,
			true,
			true,
			false,
			false,
			true,
			false,
			false
		)
	end
end