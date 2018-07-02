sand_king_epicenter_lua = class({})
LinkLuaModifier( "modifier_sand_king_epicenter_lua", "lua_abilities/sand_king_epicenter_lua/modifier_sand_king_epicenter_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sand_king_epicenter_lua_slow", "lua_abilities/sand_king_epicenter_lua/modifier_sand_king_epicenter_lua_slow", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function sand_king_epicenter_lua:OnSpellStart()
	-- Effects
	local sound_cast = "Ability.SandKing_Epicenter.spell"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Channeling
-- function sand_king_epicenter_lua:GetChannelTime()

-- end

function sand_king_epicenter_lua:OnChannelFinish( bInterrupted )
	-- cancel if fail
	if bInterrupted then 
		local sound_cast = "Ability.SandKing_Epicenter.spell"
		StopSoundOn( sound_cast, self:GetCaster() )
		return
	end

	-- unit identifier
	local caster = self:GetCaster()

	-- add modifier
	local duration = self:GetDuration()
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sand_king_epicenter_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- Effects
	local sound_cast = "Ability.SandKing_Epicenter"
	EmitSoundOn( sound_cast, caster )
end