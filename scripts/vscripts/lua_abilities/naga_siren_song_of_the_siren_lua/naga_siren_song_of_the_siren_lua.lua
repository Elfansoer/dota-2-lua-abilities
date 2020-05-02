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
naga_siren_song_of_the_siren_lua = class({})
LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_lua", "lua_abilities/naga_siren_song_of_the_siren_lua/modifier_naga_siren_song_of_the_siren_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_lua_debuff", "lua_abilities/naga_siren_song_of_the_siren_lua/modifier_naga_siren_song_of_the_siren_lua_debuff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_song_of_the_siren_lua_scepter", "lua_abilities/naga_siren_song_of_the_siren_lua/modifier_naga_siren_song_of_the_siren_lua_scepter", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function naga_siren_song_of_the_siren_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- create aura
	local modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_naga_siren_song_of_the_siren_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- check sister ability
	local ability = caster:FindAbilityByName( "naga_siren_song_of_the_siren_end_lua" )
	if not ability then
		ability = caster:AddAbility( "naga_siren_song_of_the_siren_end_lua" )
		ability:SetStolen( true )
	end

	-- check ability level
	ability:SetLevel( 1 )

	-- give info about modifier
	ability.modifier = modifier

	-- switch ability layout
	caster:SwapAbilities(
		self:GetAbilityName(),
		ability:GetAbilityName(),
		false,
		true
	)

	-- set cooldown
	ability:StartCooldown( ability:GetCooldown( 1 ) )
end

--------------------------------------------------------------------------------
-- Cancel ability
--------------------------------------------------------------------------------
naga_siren_song_of_the_siren_end_lua = class({})
function naga_siren_song_of_the_siren_end_lua:OnSpellStart()
	-- kill modifier
	self.modifier:End()
	self.modifier = nil
end