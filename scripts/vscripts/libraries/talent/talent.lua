-- Created by Elfansoer
--[[
1. How to install:
- require this file in addon_init.lua (for server & client)

2. How to use: (see examples, in Midas Talents)
- make an ability KV for the talent ability
- set BaseClass as "special_bonus_undefined"
- add key-value "IsTalent" "1" to the ability
- on the ability special kv, put
	- ability to be modified: "ability" "<target ability>"
	- special value to be modified: "<special name>" "<value>"
	- addition or multiplication: "bonus_type" "<'*' or '+'>"

3. Check Talent
To check if talent is leveled up, use TalentSystem:UnitHasTalent( unit, talentname )
(Currently server-only)

4. Generic Talent bonus
For generic bonus, set kv-pair "ability" "generic". Possible generic talent bonus:
- str
- agi
- int
- health
- mana
- hregen
- mregen
- armor
- magicresist
- attackspeed
- movespeed
- basedamage
- attackdamage
- spellamp
- attackrange
- castrange
- evasion
- cdr
- nightvision

5. Generic Modifier
Use "ScriptFile" "<modifier_path>" to use custom modifier that created when the talent is levelud up.
The modifier name must be the same as ability name.
Useful for complex talents such as:
- manabreak
- lifesteal
- spelllifesteal
- corruption
- cleave
- spell block
- reincarnation
]]

if not TalentSystem then
	TalentSystem = {}
end

local propertylist = {
	-- ["all"] = -1,
	["str"] = MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	["agi"] = MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	["int"] = MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	["health"] = MODIFIER_PROPERTY_HEALTH_BONUS,
	["mana"] = MODIFIER_PROPERTY_MANA_BONUS,
	["hregen"] = MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	["mregen"] = MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	["armor"] = MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	["magicresist"] = MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	["attackspeed"] = MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	["movespeed"] = MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	["basedamage"] = MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
	["attackdamage"] = MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	["spellamp"] = MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	["attackrange"] = MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	["castrange"] = MODIFIER_PROPERTY_CAST_RANGE_BONUS,
	["evasion"] = MODIFIER_PROPERTY_EVASION_CONSTANT,
	["cdr"] = MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	["nightvision"] = MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
}

function TalentSystem:Init()
	self.PATH = debug.getinfo(1).source:sub(2):gsub('\\','/'):match( 'scripts/vscripts.*/' )

	-- init files
	LinkLuaModifier( "modifier_talent", self.PATH .. "modifier_talent", LUA_MODIFIER_MOTION_NONE )
	ListenToGameEvent("dota_player_learned_ability", Dynamic_Wrap(TalentSystem, 'OnAbilityLearned'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(TalentSystem, 'OnNPCSpawned'), self)

	-- get Talent KVs
	local abilities = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
	self.kv = {}
	for k,v in pairs(abilities) do
		if type(v)=='table' and v["IsTalent"]==1 then
			self.kv[k] = v
		end
	end

	-- check for required ScriptFile
	for name,tab in pairs(self.kv) do
		if tab["ScriptFile"] then
			LinkLuaModifier( name, tab["ScriptFile"], LUA_MODIFIER_MOTION_NONE )
		end
	end

	-- unit queue
	self.queue = {}
	self.propertylist = propertylist
end

function TalentSystem:OnAbilityLearned( params )
	if not IsServer() then return end
	local player = EntIndexToHScript( params.player )
	local hero = player:GetAssignedHero()
	local abilityname = params.abilityname

	-- check if talent
	if not self.kv[abilityname] then return end

	-- get ability ref
	local ability = hero:FindAbilityByName( abilityname )

	-- get modifier ref
	local modifiername = "modifier_talent"
	if self.kv[abilityname]["ScriptFile"] then
		modifiername = abilityname
	end

	-- ded unit can't receive modifier
	if not hero:IsAlive() then
		self.queue[hero] = {
			ability = ability,
			name = modifiername,
		}
		return
	end

	hero:AddNewModifier(
		hero, -- player source
		ability, -- ability source
		modifiername, -- modifier name
		{} -- kv
	)
end

function TalentSystem:OnNPCSpawned( params )
	local unit = EntIndexToHScript( params.entindex )
	if not self.queue[unit] then return end
	unit:AddNewModifier(
		unit, -- player source
		self.queue[unit].ability, -- ability source
		self.queue[unit].name, -- modifier name
		{} -- kv
	)
	self.queue[unit] = nil
end

function TalentSystem:UnitHasTalent( unit, name )
	local mods = unit:FindAllModifiersByName( "modifier_talent" )
	for _,mod in pairs(mods) do
		if mod:GetAbility() and mod:GetAbility():GetAbilityName()==name then
			return true
		end
	end
	return false
end

TalentSystem:Init()