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
terrorblade_conjure_image_lua = class({})
LinkLuaModifier( "modifier_terrorblade_conjure_image_lua", "lua_abilities/terrorblade_conjure_image_lua/modifier_terrorblade_conjure_image_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function terrorblade_conjure_image_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_mirror_image.vpcf", context )
end

--------------------------------------------------------------------------------
-- Ability Start
function terrorblade_conjure_image_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "illusion_duration" )
	local outgoing = self:GetSpecialValueFor( "illusion_outgoing_damage" )
	local incoming = self:GetSpecialValueFor( "illusion_incoming_damage" )
	local distance = 72

	-- create illusion
	local illusions = CreateIllusions(
		caster, -- hOwner
		caster, -- hHeroToCopy
		{
			outgoing_damage = outgoing,
			incoming_damage = incoming,
			duration = duration,
		}, -- hModiiferKeys
		1, -- nNumIllusions
		distance, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	local illusion = illusions[1]

	self:SetContextThink( DoUniqueString( "terrorblade_conjure_image_lua" ),function()
		illusion:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_terrorblade_conjure_image_lua", -- modifier name
			{ duration = duration } -- kv
		)

		-- Play effects
		local sound_cast = "Hero_Terrorblade.ConjureImage"
		EmitSoundOn( sound_cast, illusion )

	end, FrameTime()*2)
end