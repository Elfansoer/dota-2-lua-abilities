storm_spirit_ball_lightning = class({})
LinkLuaModifier( "modifier_storm_spirit_ball_lightning", "lua_abilities/storm_spirit_ball_lightning/modifier_storm_spirit_ball_lightning", LUA_MODIFIER_MOTION_HORIZONTAL )

--------------------------------------------------------------------------------
-- Set custom mana cost
function storm_spirit_ball_lightning:GetManaCost( level )
	local base = self:GetSpecialValueFor("ball_lightning_initial_mana_base")
	local pct = self:GetSpecialValueFor("ball_lightning_initial_mana_percentage")
	local max_mana = self:GetCaster():GetMaxMana()
	return base + max_mana*(pct/100)
end

function storm_spirit_ball_lightning:OnSpellStart()
	-- get resources
	local projectile = "storm_projectile"

	-- get references
	local target_pos = self:GetCursorPosition()
	local init_pos = self:GetOrigin()
	local vDir = (target_pos - init_pos)
	local vDirection = vDir:Normalized()

	-- create projectile

	-- Add modifier
	
end
