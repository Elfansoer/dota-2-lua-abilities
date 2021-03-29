-- Created by Elfansoer
--[[
How to install:
- require this file in both addon_game_mode.lua (for server) and addon_init.lua (for client)

How to use: (see examples)
- make an ability KV for the talent ability
- set BaseClass as "special_bonus_undefined"
- add key-value "IsTalent" "1" to the ability
- on the ability special kv, put
	- ability to be modified: "ability" "<target ability"
	- special value to be modified: "<special name>" "<value>"
	- addition or multiplication: "bonus_type" "<'*' or '+'>"
]]


if not TalentSystem then
	TalentSystem = {}
end

function TalentSystem:Init()
	self.PATH = debug.getinfo(1).source:sub(2):gsub('\\','/'):match( 'scripts/vscripts.*/' )

	-- init files
	LinkLuaModifier( "modifier_talent", self.PATH .. "modifier_talent", LUA_MODIFIER_MOTION_NONE )
	ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(TalentSystem, 'OnAbilityLearned'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(TalentSystem, 'OnNPCSpawned'), self)

	-- get values
	local abilities1 = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
	local abilities2 = LoadKeyValues( "scripts/npc/npc_abilities.txt" )
	self.kv = {}
	for k,v in pairs(abilities1) do
		self.kv[k] = v
	end
	for k,v in pairs(abilities2) do
		self.kv[k] = v
	end

	-- unit queue
	self.queue = {}
end

function TalentSystem:OnAbilityLearned( params )
	if not IsServer() then return end
	local player = EntIndexToHScript( params.player )
	local hero = player:GetAssignedHero()
	local abilityname = params.abilityname

	-- check if talent
	if self.kv[abilityname]["IsTalent"]~=1 then return end

	-- get ability ref
	local ability = hero:FindAbilityByName( abilityname )

	-- ded unit can't receive modifier
	if not hero:IsAlive() then
		self.queue[hero] = ability
		return
	end

	hero:AddNewModifier(
		hero, -- player source
		ability, -- ability source
		"modifier_talent", -- modifier name
		{} -- kv
	)
end

function TalentSystem:OnNPCSpawned( params )
	local unit = EntIndexToHScript( params.entindex )
	if not self.queue[unit] then return end
	unit:AddNewModifier(
		unit, -- player source
		self.queue[unit], -- ability source
		"modifier_talent", -- modifier name
		{} -- kv
	)
	self.queue[unit] = nil
end

TalentSystem:Init()