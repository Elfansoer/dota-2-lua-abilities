slark_shadow_dance_lua = class({})
LinkLuaModifier( "modifier_slark_shadow_dance_lua", "lua_abilities/slark_shadow_dance_lua/modifier_slark_shadow_dance_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_shadow_dance_lua_passive", "lua_abilities/slark_shadow_dance_lua/modifier_slark_shadow_dance_lua_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_shadow_dance_lua:GetIntrinsicModifierName()
	return "modifier_slark_shadow_dance_lua_passive"
end

--------------------------------------------------------------------------------
-- Custom KV
function slark_shadow_dance_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function slark_shadow_dance_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local bDuration = self:GetSpecialValueFor("duration")

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slark_shadow_dance_lua", -- modifier name
		{ duration = bDuration } -- kv
	)
end