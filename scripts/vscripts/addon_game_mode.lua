-- dotadoc = require "util/sublime_json"

-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end


function OnModifierAdded( params1, params2 )
	local name = params2.name_const
	print("OnModifierAddedFilter",name)
	if params2.entindex_parent_const then
		local parent = EntIndexToHScript( params2.entindex_parent_const )
		print("parent",parent:GetUnitName())
	end
	if params2.entindex_caster_const then
		local caster = EntIndexToHScript( params2.entindex_caster_const )
		print("caster",caster:GetUnitName())
	end
	if params2.entindex_ability_const then
		local ability = EntIndexToHScript( params2.entindex_ability_const )
		print("ability",ability:GetAbilityName())
	end

	return true
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )
	]]
	PrecacheResource( "particle", "particles/ui_mouseactions/range_finder_cone.vpcf", context )
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = CAddonTemplateGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
	print( "Template addon is loaded." )
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )

	require( "scripts/vscripts/libraries/vector_target/vector_target" )
	require( "scripts/vscripts/libraries/filters/filters" )
	require( "scripts/vscripts/libraries/talent/talent" )
	FilterManager:Init()
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end
