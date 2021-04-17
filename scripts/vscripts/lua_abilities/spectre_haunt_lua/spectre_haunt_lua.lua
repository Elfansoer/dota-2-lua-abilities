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
spectre_haunt_lua = class({})
LinkLuaModifier( "modifier_spectre_haunt_lua", "lua_abilities/spectre_haunt_lua/modifier_spectre_haunt_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function spectre_haunt_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spectre/spectre_haunt.vpcf", context )
end

function spectre_haunt_lua:Spawn()
	if not IsServer() then return end
end

function spectre_haunt_lua:OnUpgrade( level )
	if not IsServer() then return end
	local sub = self:GetCaster():FindAbilityByName( "spectre_reality_lua" )
	if not sub then
		sub = self:GetCaster():AddAbility( "spectre_reality_lua" )
	end
	sub:SetLevel( 1 )
end

--------------------------------------------------------------------------------
-- Ability Start
function spectre_haunt_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )
	local outgoing = self:GetSpecialValueFor( "illusion_damage_outgoing" )
	local incoming = self:GetSpecialValueFor( "illusion_damage_incoming" )
	local distance = 70

	-- find enemies (might want to filter search even more, considering Monkey soldier might spawn haunts )
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- Play effects
	local sound_cast = "Hero_Spectre.HauntCast"
	EmitSoundOn( sound_cast, caster )

	if #heroes<1 then return end

	-- create illusions
	local illusions = CreateIllusions(
		-- caster, -- hOwner
		caster,
		caster, -- hHeroToCopy
		{
			outgoing_damage = outgoing,
			incoming_damage = incoming,
			duration = duration,
		}, -- hModiiferKeys
		#heroes, -- nNumIllusions
		distance, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	

	-- move illusions
	local i = 0
	for _,hero in pairs(heroes) do
		i = i+1
		local illusion = illusions[i]
		illusion:SetControllableByPlayer( -1, false )

		-- move to heroes
		FindClearSpaceForUnit( illusion, hero:GetOrigin(), false )

		-- Play effects
		local sound_cast = "Hero_Spectre.Haunt"
		EmitSoundOn( sound_cast, illusion )
	end

	-- delayed by 2 frames
	self:SetContextThink( DoUniqueString( "spectre_haunt_lua" ),function()
		local i = 0
		for _,hero in pairs(heroes) do
			i = i+1
			local illusion = illusions[i]

			-- add modifier to illusion
			illusion:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_spectre_haunt_lua", -- modifier name
				{
					duration = duration,
					target = hero:entindex(),
				} -- kv
			)
		end

	end, FrameTime()*2)
end

--------------------------------------------------------------------------------
-- Sub-ability: Reality
--------------------------------------------------------------------------------
spectre_reality_lua = class({})

function spectre_reality_lua:Spawn()
	if not IsServer() then return end
	self:SetActivated( false )
end

function spectre_reality_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- find haunts
	local haunts = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		FIND_UNITS_EVERYWHERE,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	local origin = caster:GetOrigin()
	local target = nil
	local mdistance = 99999
	for _,haunt in pairs(haunts) do
		if haunt:HasModifier( "modifier_spectre_haunt_lua" ) and haunt:GetPlayerOwner()==caster:GetPlayerOwner() then
			-- get distance
			local distance = (haunt:GetOrigin()-point):Length2D()

			if distance<mdistance then
				target = haunt
				mdistance = distance
			end
		end
	end

	if not target then return end

	-- swap position
	local pos = target:GetOrigin()
	FindClearSpaceForUnit( target, origin, true )
	FindClearSpaceForUnit( caster, pos, true )
	caster:SetForwardVector( target:GetForwardVector() )

	-- play effects
	local sound_cast = "Hero_Spectre.Reality"
	EmitSoundOn( sound_cast, caster )
end
