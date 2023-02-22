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
modifier_sally_mirage = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_sally_mirage:IsHidden()
	return true
end

function modifier_sally_mirage:IsDebuff()
	return false
end

function modifier_sally_mirage:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_sally_mirage:OnCreated( kv )
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	-- references
	self.count = self:GetAbility():GetSpecialValueFor( "illusion_count" )
	self.outgoing = self:GetAbility():GetSpecialValueFor( "illusion_outgoing" )
	self.incoming = self:GetAbility():GetSpecialValueFor( "illusion_incoming" )
	self.duration = self:GetAbility():GetSpecialValueFor( "duration" )

	self.distance = 10

	if not IsServer() then return end

	ProjectileManager:ProjectileDodge( self.parent )
	self.parent:Purge(false, true, false, false, false)
end

function modifier_sally_mirage:OnRefresh( kv )
end

function modifier_sally_mirage:OnRemoved()
end

function modifier_sally_mirage:OnDestroy()
	if not IsServer() then return end

	local illusions = CreateIllusions(
		self.parent, -- hOwner
		self.parent, -- hHeroToCopy
		{
			outgoing_damage = self.outgoing,
			incoming_damage = self.incoming,
			duration = self.duration,
		}, -- hModiiferKeys
		self.count, -- nNumIllusions
		self.distance, -- nPadding
		true, -- bScramblePosition
		true -- bFindClearSpace
	)

	-- register illusions
	for _,illusion in pairs(illusions) do
		illusion:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_sally_mirage_illusion",
			{}
		)

		local sword_dance_parent = self.parent:FindModifierByName( "modifier_sally_sword_dance" )
		local sword_dance_illusion = illusion:FindModifierByName( "modifier_sally_sword_dance" )
		if sword_dance_parent and sword_dance_illusion then
			sword_dance_illusion:SetStackCount( sword_dance_parent:GetStackCount() )
		end

		-- cast super acceleration
		local ability = illusion:FindAbilityByName("sally_super_acceleration")
		if ability and ability:GetLevel() > 0 then
			ability:OnSpellStart()
		end	
	end

	-- cast super acceleration
	local ability = self.parent:FindAbilityByName("sally_super_acceleration")
	if ability and ability:GetLevel() > 0 then
		ability:OnSpellStart()
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_sally_mirage:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_sally_mirage:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_mirror_image.vpcf"
end

function modifier_sally_mirage:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end