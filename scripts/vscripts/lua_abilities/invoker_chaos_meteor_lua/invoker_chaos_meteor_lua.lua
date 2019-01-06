invoker_chaos_meteor_lua = class({})
LinkLuaModifier( "modifier_invoker_chaos_meteor_lua_thinker", "lua_abilities/invoker_chaos_meteor_lua/modifier_invoker_chaos_meteor_lua_thinker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_chaos_meteor_lua_burn", "lua_abilities/invoker_chaos_meteor_lua/modifier_invoker_chaos_meteor_lua_burn", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_chaos_meteor_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_chaos_meteor_lua_thinker", -- modifier name
		{}, -- kv
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)
end
--------------------------------------------------------------------------------
-- Projectile
function invoker_chaos_meteor_lua:OnStolen( hAbility )
	self.orbs = hAbility.orbs
end

function invoker_chaos_meteor_lua:GetOrbSpecialValueFor( key_name, orb_name )
	if not IsServer() then return 0 end
	if not self.orbs[orb_name] then return 0 end
	return self:GetLevelSpecialValueFor( key_name, self.orbs[orb_name] )
end