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
modifier_maple_indomitable_guardian = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_maple_indomitable_guardian:IsHidden()
	return true
end

function modifier_maple_indomitable_guardian:IsDebuff()
	return false
end

function modifier_maple_indomitable_guardian:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_indomitable_guardian:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	if not IsServer() then return end
end

function modifier_maple_indomitable_guardian:OnRefresh( kv )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )	
end

function modifier_maple_indomitable_guardian:OnRemoved()
end

function modifier_maple_indomitable_guardian:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_maple_indomitable_guardian:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}

	return funcs
end

function modifier_maple_indomitable_guardian:OnTakeDamage( params )
	if params.unit~=self.parent then return end
	if self.parent:PassivesDisabled() then return end
	if not self.ability:IsFullyCastable() then return end
	if self.parent:GetHealthPercent() > 5 then return end

	-- set health min to 1 so that unit can receive modifier (or else unit is considered dead)
	if self.parent:GetHealth()<1 then
		self.parent:ModifyHealth(1, self.ability, false, 0)
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_maple_indomitable_guardian_buff",
		{duration = self.duration}
	)
	self.ability:UseResources(true, false, true)
end