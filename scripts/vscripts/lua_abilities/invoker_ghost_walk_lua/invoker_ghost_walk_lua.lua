invoker_ghost_walk_lua = class({})
LinkLuaModifier( "modifier_invoker_ghost_walk_lua", "lua_abilities/invoker_ghost_walk_lua/modifier_invoker_ghost_walk_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_lua_debuff", "lua_abilities/invoker_ghost_walk_lua/modifier_invoker_ghost_walk_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function invoker_ghost_walk_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_invoker_ghost_walk_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	local sound_cast = "Hero_Invoker.GhostWalk"
	EmitSoundOn( sound_cast, caster )
end