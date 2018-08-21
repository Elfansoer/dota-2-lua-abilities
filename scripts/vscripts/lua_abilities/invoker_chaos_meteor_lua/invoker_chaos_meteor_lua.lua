invoker_chaos_meteor_lua = class({})
LinkLuaModifier( "modifier_invoker_chaos_meteor_lua_thinker", "lua_abilities/invoker_chaos_meteor_lua/modifier_invoker_chaos_meteor_lua_thinker", LUA_MODIFIER_MOTION_HORIZONTAL )
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
		{ 
			x = caster:GetOrigin().x,
			y = caster:GetOrigin().y,
			z = caster:GetOrigin().z,
		}, -- kv
		point,
		self:GetCaster():GetTeamNumber(),
		false
	)

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_chaos_meteor_lua_thinker", -- modifier name
		{ 
			x = point.x,
			y = point.y,
			z = point.z,
		} -- kv
	)
end
--------------------------------------------------------------------------------
-- Projectile
-- function invoker_chaos_meteor_lua:OnProjectileHit( target, location )
-- end