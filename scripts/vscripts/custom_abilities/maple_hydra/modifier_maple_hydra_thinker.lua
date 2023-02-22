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
modifier_maple_hydra_thinker = class({})

--------------------------------------------------------------------------------
-- Classifications

--------------------------------------------------------------------------------
-- Initializations
function modifier_maple_hydra_thinker:OnCreated( kv )
	-- references
	self.radius = self:GetAbility():GetSpecialValueFor( "trail_radius" )

	if not IsServer() then return end
end

function modifier_maple_hydra_thinker:OnRefresh( kv )
end

function modifier_maple_hydra_thinker:OnRemoved()
end

function modifier_maple_hydra_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove(self:GetParent())
end

function modifier_maple_hydra_thinker:SetDPS( dps )
	self.dps = dps
	self:SetStackCount(1)
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_maple_hydra_thinker:IsAura()
	return self:GetStackCount()==1
end

function modifier_maple_hydra_thinker:GetModifierAura()
	return "modifier_maple_hydra_debuff"
end

function modifier_maple_hydra_thinker:GetAuraRadius()
	return self.radius
end

function modifier_maple_hydra_thinker:GetAuraDuration()
	return 0.5
end

function modifier_maple_hydra_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_maple_hydra_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_maple_hydra_thinker:GetAuraEntityReject( hEntity )
	if IsServer() then
		
	end

	return false
end