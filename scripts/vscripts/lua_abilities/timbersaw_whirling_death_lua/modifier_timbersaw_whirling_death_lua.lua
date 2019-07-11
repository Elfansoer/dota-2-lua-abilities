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
modifier_timbersaw_whirling_death_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_timbersaw_whirling_death_lua:IsHidden()
	return false
end

function modifier_timbersaw_whirling_death_lua:IsDebuff()
	return true
end

function modifier_timbersaw_whirling_death_lua:IsStunDebuff()
	return false
end

function modifier_timbersaw_whirling_death_lua:IsPurgable()
	return true
end

function modifier_timbersaw_whirling_death_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_timbersaw_whirling_death_lua:OnCreated( kv )
	self.parent = self:GetParent()

	-- references
	self.stat_loss_pct = self:GetAbility():GetSpecialValueFor( "stat_loss_pct" )

	if not IsServer() then return end
	-- calculate stat loss
	self.stat_loss = -self.parent:GetPrimaryStatValue() * self.stat_loss_pct/100

	-- reduce health by 20 per strength loss if strength hero
	if self.parent:GetPrimaryAttribute()==DOTA_ATTRIBUTE_STRENGTH then
		self:GetParent():ModifyHealth( self:GetParent():GetHealth() + 20*self.stat_loss, self:GetAbility(), true, DOTA_DAMAGE_FLAG_NONE )
	end
end

function modifier_timbersaw_whirling_death_lua:OnRefresh( kv )
	
end

function modifier_timbersaw_whirling_death_lua:OnRemoved()
	if not IsServer() then return end

	-- give health back by 19 per strength if strength hero
	if self.parent:GetPrimaryAttribute()==DOTA_ATTRIBUTE_STRENGTH then
		self:GetParent():ModifyHealth( self:GetParent():GetHealth() - 19*self.stat_loss, self:GetAbility(), true, DOTA_DAMAGE_FLAG_NONE )
	end
end

function modifier_timbersaw_whirling_death_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_timbersaw_whirling_death_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}

	return funcs
end

if IsServer() then
	function modifier_timbersaw_whirling_death_lua:GetModifierBonusStats_Agility()
		if self.parent:GetPrimaryAttribute()~=DOTA_ATTRIBUTE_AGILITY then return 0 end
		return self.stat_loss or 0
	end
	function modifier_timbersaw_whirling_death_lua:GetModifierBonusStats_Intellect()
		if self.parent:GetPrimaryAttribute()~=DOTA_ATTRIBUTE_INTELLECT then return 0 end
		return self.stat_loss or 0
	end
	function modifier_timbersaw_whirling_death_lua:GetModifierBonusStats_Strength()
		if self.parent:GetPrimaryAttribute()~=DOTA_ATTRIBUTE_STRENGTH then return 0 end
		return self.stat_loss or 0
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_timbersaw_whirling_death_lua:GetStatusEffectName()
	return "particles/status_fx/status_effect_shredder_whirl.vpcf"
end

function modifier_timbersaw_whirling_death_lua:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_timbersaw_whirling_death_lua:GetEffectName()
	return "particles/units/heroes/hero_shredder/shredder_whirling_death_debuff.vpcf"
end

function modifier_timbersaw_whirling_death_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end