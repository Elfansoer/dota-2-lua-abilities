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
modifier_leshrac_lightning_storm_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_leshrac_lightning_storm_lua:IsHidden()
	return false
end

function modifier_leshrac_lightning_storm_lua:IsDebuff()
	return true
end

function modifier_leshrac_lightning_storm_lua:IsStunDebuff()
	return false
end

function modifier_leshrac_lightning_storm_lua:IsPurgable()
	return true
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_leshrac_lightning_storm_lua:OnCreated( kv )
	if IsServer() then
		-- references
		self.slow = kv.slow
	end
end

function modifier_leshrac_lightning_storm_lua:OnRefresh( kv )
	
end

function modifier_leshrac_lightning_storm_lua:OnRemoved()
end

function modifier_leshrac_lightning_storm_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_leshrac_lightning_storm_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACKED,
	}

	return funcs
end

function modifier_leshrac_lightning_storm_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end