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
modifier_sally_sword_dance_active = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_sword_dance_active:IsHidden()
	return false
end

function modifier_sally_sword_dance_active:IsDebuff()
	return false
end

function modifier_sally_sword_dance_active:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_sword_dance_active:OnCreated( kv )
	self.parent = self:GetParent()
	
	if not IsServer() then return end
	self.evaded = false
end

function modifier_sally_sword_dance_active:OnRefresh( kv )
	
end

function modifier_sally_sword_dance_active:OnRemoved()
end

function modifier_sally_sword_dance_active:OnDestroy()
	if not IsServer() then return end
	local modifier = self.parent:FindModifierByName("modifier_sally_sword_dance")
	if modifier then
		if self.evaded then
			modifier:EvadeSuccess()
		else
			modifier:EvadeFail()
		end
	end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_sally_sword_dance_active:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_MODIFIER_ADDED,

		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_EVENT_ON_ATTACK_FAIL,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_AVOID_DAMAGE,
	}

	return funcs
end

function modifier_sally_sword_dance_active:OnModifierAdded( params )
	if params.unit~=self.parent then return end
	if not params.added_buff:IsDebuff() then return end
	if not params.added_buff:GetCaster():IsOwnedByAnyPlayer() then return end

	-- only hard dispels on this frame
	self.parent:Purge(false, true, true, true, true)

	-- if no longer exist, it is successfully purged
	if not self.parent:HasModifier(params.added_buff:GetName()) then
		self.evaded = true
	end
end

function modifier_sally_sword_dance_active:OnAttackLanded( params )
	if params.target == self.parent and params.attacker:IsOwnedByAnyPlayer() then
		-- attack attempt detected, successfully procs (even though true strike)
		self.evaded = true
	end
end

function modifier_sally_sword_dance_active:OnAttackFail( params )
	if params.target == self.parent and params.attacker:IsOwnedByAnyPlayer() then
		self.evaded = true
	end
end


function modifier_sally_sword_dance_active:GetModifierEvasion_Constant( params )
	return 100
end

function modifier_sally_sword_dance_active:GetModifierAvoidDamage( params )
	if params.target == self.parent and params.attacker:IsOwnedByAnyPlayer() then
		self.evaded = true
	end

	return 1
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sally_sword_dance_active:GetEffectName()
	return "particles/units/heroes/hero_dazzle/dazzle_shallow_grave.vpcf"
end

function modifier_sally_sword_dance_active:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end