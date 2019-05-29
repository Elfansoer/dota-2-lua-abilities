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
modifier_dragon_knight_elder_dragon_form_lua_corrosive = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsHidden()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsDebuff()
	return true
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsStunDebuff()
	return false
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "corrosive_breath_damage" )

	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		damage = damage*1.5
	end

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(), --Optional.
	}

	if not IsServer() then return end
	self:StartIntervalThink( 1 )
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "corrosive_breath_damage" )

	local level = self:GetAbility():GetLevel()
	if self:GetCaster():HasScepter() then
		level = level + 1
	end
	if level==4 then
		damage = damage*1.5
	end


	-- update damage
	self.damageTable.damage = damage
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnRemoved()
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnDestroy()
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dragon_knight_elder_dragon_form_lua_corrosive:GetEffectName()
	return "particles/units/heroes/hero_dragon_knight/dragon_knight_corrosion_debuff.vpcf"
end

function modifier_dragon_knight_elder_dragon_form_lua_corrosive:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end