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
modifier_test_knockback = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_test_knockback:IsHidden()
	return false
end

function modifier_test_knockback:IsPurgable()
	return false
end

function modifier_test_knockback:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_test_knockback:OnCreated( kv )
	if not IsServer() then return end
	-- apply knockback
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			duration = 1,
			distance = 300,
			height = 1000,
		} -- kv
	)

	-- Start interval
	self:StartIntervalThink( 0.5 )
end

function modifier_test_knockback:OnRefresh( kv )
	
end

function modifier_test_knockback:OnRemoved()
end

function modifier_test_knockback:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_test_knockback:OnIntervalThink()
	-- apply knockback
	local direction = self:GetParent():GetForwardVector()
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			duration = 1.6,
			distance = 300,
			height = 300,
			direction_x = direction.x,
			direction_y = direction.y,
		} -- kv
	)
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_test_knockback:GetEffectName()
	return "particles/generic_gameplay/generic_silenced.vpcf"
end

function modifier_test_knockback:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end