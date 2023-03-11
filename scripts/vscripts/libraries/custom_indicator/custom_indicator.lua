-- Created by Elfansoer
--[[
	HOW TO USE:
	- Include this file in 'addon_init.lua' (for Lua client)
	- Copy 'custom_indicator.js' to panorama scripts folder (and include it in custom_ui_manifest.xml)
	- Add custom indicator entry on 'scripts/custom.gameevents' (see the file):
		"custom_indicator"
		{
			"ability"	"int"
			"behavior"	"int"
			"event"		"byte"
			"unit"		"int"
			"worldX"	"float"
			"worldY"	"float"
			"worldZ"	"float"
		}
	- Register the ability using CustomIndicator:RegisterAbility( self ) in ability:Spawn() (see examples).
	- Implement CreateCustomIndicator, UpdateCustomIndicator, and DestroyCustomIndicator (see examples).

	OVERVIEW:
	- All 3 abstract functions receives 3 parameters:
		- position, where current cursor is pointed at on the world
		- unit, where current mouse is pointing at. nil if no unit under cursor
		- behavior, currently allows these clickbehaviors:
			- DOTA_CLICK_BEHAVIOR_CAST: when player is aiming to cast the ability
			- DOTA_CLICK_BEHAVIOR_VECTOR_CAST: when player is aiming on second phase of vector target ability

	- About the functions:
		- CreateCustomIndicator triggers when player starts to cast the ability
		- UpdateCustomIndicator gets called repeatedly while player is still casting
		- DestroyCustomIndicator triggers when player finishes casting (either confirming cast or cancelling)
			- position and unit refers to last position and last unit before casting ends.

	- Each 3 functions gets called separately for different behaviors.
		- For non-vector abilities, 3 functions are only for DOTA_CLICK_BEHAVIOR_CAST behavior
		- For vector abilities, 3 functions gets called during DOTA_CLICK_BEHAVIOR_CAST,
			then all 3 gets called again during DOTA_CLICK_BEHAVIOR_VECTOR_CAST
		- The order is pretty much like this:
			CreateCustomIndicator( BEHAVIOR_CAST )
			UpdateCustomIndicator( BEHAVIOR_CAST ) (loops)
			DestroyCustomIndicator( BEHAVIOR_CAST )
			CreateCustomIndicator( BEHAVIOR_VECTOR_CAST )
			UpdateCustomIndicator( BEHAVIOR_VECTOR_CAST ) (loops)
			DestroyCustomIndicator( BEHAVIOR_VECTOR_CAST )
]]

local BEHAVIOR_EVENT_START = 0;
local BEHAVIOR_EVENT_UPDATE = 1;
local BEHAVIOR_EVENT_END = 2;

if not CustomIndicator then
	CustomIndicator = {}
end

function CustomIndicator:Init()
	if self.initialized then return end

	self.initialized = true
	self.listeners = {}
	ListenToGameEvent("custom_indicator", Dynamic_Wrap(CustomIndicator, 'PanoramaListener'), self)
end

function CustomIndicator:RegisterAbility( ability )
	local ability_index = ability:entindex()
	self.listeners[ ability_index ] = ability
end

function CustomIndicator:PanoramaListener( data )
	local ability = self.listeners[ data.ability ]
	if ability then
		local pos = Vector( data.worldX, data.worldY, data.worldZ )
		local unit = nil
		if data.unit then
			unit = EntIndexToHScript( data.unit )
		end

		if data.event==BEHAVIOR_EVENT_START then
			if ability.CreateCustomIndicator then
				ability:CreateCustomIndicator( pos, unit, data.behavior )
			end
		elseif data.event==BEHAVIOR_EVENT_UPDATE then
			if ability.UpdateCustomIndicator then
				ability:UpdateCustomIndicator( pos, unit, data.behavior )
			end
		elseif data.event==BEHAVIOR_EVENT_END then
			if ability.DestroyCustomIndicator then
				ability:DestroyCustomIndicator( pos, unit, data.behavior )
			end
		end
	end
end

CustomIndicator:Init()

return CustomIndicator