-- Created by Elfansoer
--[[
- Check False/True piercing projectile
- Projectile Events
	Launch: Projectile launched
	Think: Projectile in flight
	Hit: Projectile hits target
		- pierce procs multiple times
		- nonpierce procs once or none if disjointed
	End: Piercing ended, Non-piercing hits target (same with ProjHit)
		- pierce has no target
		- nonpierce has target, if disjointed no target
- Issues
	- Red help when dominated
	- Breach castrange bonus does not affect GetCastRange
		help, mask, tap is duration, duration, radius
	- ping area hit is too good
	- Switch area modifier is unclear
- Test issues
	- Client/Panorama update should be broadcast to all client (minor)
	- enemy modifiers should have greyed out in panorama (minor)
- Improvements
	- set cast range as abilityspecial
	- "Modifier" to "Upgrade"
	- mark for deletion delayed by existing projectiles/buffs
- not in progress
	- help upgrade concept (illusion is not good)
- next
	localization
	breach castrange
		- help and mask left
	rework abilities
		crash vs cull, switch, get, ping
	delete after no refcount
	onstolen
	multiple same hero
	turn
]]

require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_base" )
require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_projectile" )
require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_area" )

--------------------------------------------------------------------------------
-- Game Modifiers
LinkLuaModifier( "modifier_red_transistor_access_modifiers", "custom_abilities/red_transistor_access/modifier_red_transistor_access_modifiers", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_base_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_bounce_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_breach_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_crash_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_flood_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_get_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_ping_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_purge_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_switch_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_cull_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_help_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_jaunt_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_load_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_mask_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_spark_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_tap_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_void_passive", "custom_abilities/red_transistor_access/modifier_red_transistor_access_passives", LUA_MODIFIER_MOTION_NONE )

LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_slowed_lua", "lua_abilities/generic/modifier_generic_slowed_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_red_transistor_purge_passive_armor", "custom_abilities/red_transistor_access/modifier_red_transistor_purge_passive_armor", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Empty and Locked
--------------------------------------------------------------------------------
red_transistor_empty_1 = class(generic_base)
red_transistor_empty_2 = class(generic_base)
red_transistor_empty_3 = class(generic_base)
red_transistor_empty_4 = class(generic_base)
red_transistor_locked_1 = class(generic_base)
red_transistor_locked_2 = class(generic_base)
red_transistor_locked_3 = class(generic_base)
red_transistor_locked_4 = class(generic_base)

--------------------------------------------------------------------------------
-- Passive modifiers
--------------------------------------------------------------------------------
local passive_name = {
	["red_transistor_empty"] = "modifier_red_transistor_base_passive",
	["red_transistor_empty_1"] = "modifier_red_transistor_base_passive",
	["red_transistor_empty_4"] = "modifier_red_transistor_base_passive",
	["red_transistor_locked"] = "modifier_red_transistor_base_passive",
	["red_transistor_locked_1"] = "modifier_red_transistor_base_passive",
	["red_transistor_locked_4"] = "modifier_red_transistor_base_passive",
	["red_transistor_bounce"] = "modifier_red_transistor_bounce_passive",
	["red_transistor_breach"] = "modifier_red_transistor_breach_passive",
	["red_transistor_crash"] = "modifier_red_transistor_crash_passive",
	["red_transistor_flood"] = "modifier_red_transistor_flood_passive",
	["red_transistor_get"] = "modifier_red_transistor_get_passive",
	["red_transistor_ping"] = "modifier_red_transistor_ping_passive",
	["red_transistor_purge"] = "modifier_red_transistor_purge_passive",
	["red_transistor_switch"] = "modifier_red_transistor_switch_passive",
	["red_transistor_cull"] = "modifier_red_transistor_cull_passive",
	["red_transistor_help"] = "modifier_red_transistor_help_passive",
	["red_transistor_jaunt"] = "modifier_red_transistor_jaunt_passive",
	["red_transistor_load"] = "modifier_red_transistor_load_passive",
	["red_transistor_mask"] = "modifier_red_transistor_mask_passive",
	["red_transistor_spark"] = "modifier_red_transistor_spark_passive",
	["red_transistor_tap"] = "modifier_red_transistor_tap_passive",
	["red_transistor_void"] = "modifier_red_transistor_void_passive",
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Abilities list
--------------------------------------------------------------------------------
local abilities = {
	["red_transistor_empty"] = red_transistor_empty_1,
	["red_transistor_locked"] = red_transistor_locked_1,

	["red_transistor_bounce"] = red_transistor_bounce,
	["red_transistor_breach"] = red_transistor_breach,
	["red_transistor_crash"] = red_transistor_crash,
	["red_transistor_flood"] = red_transistor_flood,
	["red_transistor_get"] = red_transistor_get,
	["red_transistor_ping"] = red_transistor_ping,
	["red_transistor_purge"] = red_transistor_purge,
	["red_transistor_switch"] = red_transistor_switch,

	["red_transistor_cull"] = red_transistor_cull,
	["red_transistor_help"] = red_transistor_help,
	["red_transistor_jaunt"] = red_transistor_jaunt,
	["red_transistor_load"] = red_transistor_load,
	["red_transistor_mask"] = red_transistor_mask,
	["red_transistor_spark"] = red_transistor_spark,
	["red_transistor_tap"] = red_transistor_tap,
	["red_transistor_void"] = red_transistor_void,
}

local ability_index = {
	["red_transistor_empty"] = 0,

	["red_transistor_bounce"] = 1,
	["red_transistor_breach"] = 2,
	["red_transistor_crash"] = 3,
	["red_transistor_flood"] = 4,
	["red_transistor_get"] = 5,
	["red_transistor_ping"] = 6,
	["red_transistor_purge"] = 7,
	["red_transistor_switch"] = 8,

	["red_transistor_cull"] = 9,
	["red_transistor_help"] = 10,
	["red_transistor_jaunt"] = 11,
	["red_transistor_load"] = 12,
	["red_transistor_mask"] = 13,
	["red_transistor_spark"] = 14,
	["red_transistor_tap"] = 15,
	["red_transistor_void"] = 16,

	["red_transistor_locked"] = 17,	

	["red_transistor_empty_1"] = 0,
	["red_transistor_empty_2"] = 0,
	["red_transistor_empty_3"] = 0,
	["red_transistor_empty_4"] = 0,
	["red_transistor_locked_1"] = 17,	
	["red_transistor_locked_2"] = 17,	
	["red_transistor_locked_3"] = 17,	
	["red_transistor_locked_4"] = 17,	

	[0] = "red_transistor_empty",

	[1] = "red_transistor_bounce",
	[2] = "red_transistor_breach",
	[3] = "red_transistor_crash",
	[4] = "red_transistor_flood",
	[5] = "red_transistor_get",
	[6] = "red_transistor_ping",
	[7] = "red_transistor_purge",
	[8] = "red_transistor_switch",

	[9] = "red_transistor_cull",
	[10] = "red_transistor_help",
	[11] = "red_transistor_jaunt",
	[12] = "red_transistor_load",
	[13] = "red_transistor_mask",
	[14] = "red_transistor_spark",
	[15] = "red_transistor_tap",
	[16] = "red_transistor_void",

	[17] = "red_transistor_locked",
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Access
--------------------------------------------------------------------------------
red_transistor_access = class({})

--------------------------------------------------------------------------------
-- Init Abilities
function red_transistor_access:Spawn()
	if not IsServer() then
		-- client code
		if self.kv then return end

		-- get ability references
		self.abilities = abilities
		self.ability_index = ability_index
		self.passive_name = passive_name
		self.kv = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
		for k,v in pairs(self.kv) do
			if not self.ability_index[k] then
				self.kv[k] = nil
			end
		end
		return
	end

	self:SetLevel( 1 )

	-- vars
	self.MAX_SLOT = 4
	self.MAX_UPGRADE = 2

	self.SLOT_SIZE = 1 + self.MAX_UPGRADE
	self.MAX_ABILITIES = self.SLOT_SIZE * self.MAX_SLOT

	self.PASSIVE_SLOT = 4

	-- get ability references
	self.abilities = abilities
	self.ability_index = ability_index
	self.passive_name = passive_name
	self.kv = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
	for k,v in pairs(self.kv) do
		if not self.ability_index[k] then
			self.kv[k] = nil
		end
	end

	-- set initial states as locked
	self.list = {}
	for i=1,self.MAX_ABILITIES do
		self.list[i] = 17
	end

	-- set abilities levels as 0
	self.levels = {}
	for i=1,self.MAX_SLOT do
		self.levels[i] = 0
	end

	-- get slot handles
	self.slots = {}
	for i=1,self.MAX_SLOT do
		self.slots[i] = self:GetCaster():FindAbilityByName( "red_transistor_locked_"..i )
	end

	-- initialize abilities
	for i,ability in pairs(self.slots) do
		local upgrades = {}
		for i=1,self.MAX_UPGRADE do
			table.insert( upgrades, 17 )
		end
		ability:Install( self, upgrades, self:SlotType( i ) )
	end

	-- listen to event
	CustomGameEventManager:RegisterListener( "red_transistor_access", self.EventConfirm )
end

--------------------------------------------------------------------------------
-- Listener
function red_transistor_access:EventUpgrade( ability )
	local level = ability:GetLevel()

	-- get slot
	local slot
	for i,abil in pairs(self.slots) do
		if abil==ability then
			slot = i
		end
	end

	-- update ref
	self.levels[slot] = ability:GetLevel()

	-- update list (ability upgrade means change Locked to Empty)
	local ctr = slot-1
	self.list[ ctr*self.SLOT_SIZE + ability:GetLevel()] = 0

	-- update abilities
	if level==1 then
		-- create Empty ability
		local caster = ability:GetCaster()
		local empty = caster:AddAbility( "red_transistor_empty_" .. slot )

		-- update level
		self.lock = true
		empty:SetLevel( self.levels[slot] )
		self.lock = false

		-- swap
		caster:SwapAbilities(
			empty:GetAbilityName(),
			ability:GetAbilityName(),
			true,
			false
		)

		-- Install
		local upgrades = {}
		for i=1,self.MAX_UPGRADE do
			table.insert( upgrades, 17 )
		end
		empty:Install( self, upgrades, self:SlotType( slot ) )

		-- set reference
		self.slots[slot] = empty

		-- remove locked
		ability:Uninstall()
		caster:RemoveAbilityByHandle( ability )
	elseif level>1 then
		-- change locked upgrade to empty upgrade
		ability:Replace( self, level-1, "red_transistor_empty" )		
	end

	-- Refresh Panorama
	local data = {}
	data['refresh'] = 1
	CustomGameEventManager:Send_ServerToAllClients( "red_transistor_access", data )

	self:PrintStatus()
end

function red_transistor_access.EventConfirm( playerID, data )
	local self = EntIndexToHScript( tonumber(data.ability) )

	-- convert to list
	local data_list = {}
	for k,v in pairs(data.data) do
		data_list[tonumber(k)] = v
	end
	data_list[0] = nil

	local list = data_list

	-- Validation
	local valid = self:Validate( list )
	if not valid then
		-- fail
		return
	end

	-- start cooldown
	self:StartCooldown( self:GetCooldown(-1) )

	-- update ability layout
	self:UpdateAbilities( list )

	-- update ability list
	self.list = list
	
	-- Refresh Panorama
	local data = {}
	data['refresh'] = 1
	CustomGameEventManager:Send_ServerToAllClients( "red_transistor_access", data )

	-- start cooldown
	self:UseResources( true, false, true )

	self:PrintStatus()
end

--------------------------------------------------------------------------------
-- Update UI
function red_transistor_access:UpdateAbilities( list )
	print("UpdateAbilities")
	local caster = self:GetCaster()

	-- Uninstall Upgrades
	for _,ability in pairs(self.slots) do
		ability:Uninstall()
	end

	-- Change ability layout
	local mark_for_deletion = {}
	for ctr=0,self.MAX_SLOT-1 do
		-- layout is main-up1-up2-main-up1-...
		local slot = ctr+1
		local i = ctr*self.SLOT_SIZE + 1

		local new_ability_index = list[i]
		local new_ability_name = self.ability_index[new_ability_index]
		print(i,"new_ability",self.ability_index[new_ability_index])

		local modifiers = {}
		for j=1,self.MAX_UPGRADE do
			table.insert( modifiers, list[ i+j ] )
		end

		-- Assume not locked nor empty
		if new_ability_index==17 then
		-- Locked ability
			-- Locked do not change anything. Reinstall.
			self.slots[slot]:Install( self, modifiers, self:SlotType( slot ) )

		elseif new_ability_index==0 then
		-- Empty ability

			if self.list[i]==0 then
				-- previously also empty. Reinstall.
				self.slots[slot]:Install( self, modifiers, self:SlotType( slot ) )
			else
				-- previously was ability
				local new_ability = caster:AddAbility( "red_transistor_empty_" .. slot )

				-- update level			
				self.lock = true
				new_ability:SetLevel( self.levels[slot] )
				self.lock = false

				-- get old one
				local old_ability = self.slots[slot]

				-- swap ability
				caster:SwapAbilities( 
					new_ability:GetAbilityName(),
					old_ability:GetAbilityName(),
					true,
					false
				)
				mark_for_deletion[old_ability] = true

				-- install upgrades
				new_ability:Install( self, modifiers, self:SlotType( slot ) )

				-- set references
				self.slots[slot] = new_ability
				
			end
		else
		-- not Locked or Empty

			-- find existing ability
			local new_ability = caster:FindAbilityByName( new_ability_name )
			if not new_ability then

				-- create new
				new_ability = caster:AddAbility( new_ability_name )
				self.lock = true
				new_ability:SetLevel( self.levels[slot] )
				self.lock = false

				-- get old one
				local old_ability = self.slots[slot]

				-- swap ability
				caster:SwapAbilities( 
					new_ability:GetAbilityName(),
					old_ability:GetAbilityName(),
					true,
					false
				)
				mark_for_deletion[old_ability] = true

				-- install upgrades
				new_ability:Install( self, modifiers, self:SlotType( slot ) )

				-- set references
				self.slots[slot] = new_ability
			else
				-- dont delete it
				mark_for_deletion[new_ability] = nil

				-- check on correct slot
				if self.slots[slot]==new_ability then
					-- show if hidden
					new_ability:SetHidden( false )

					-- install upgrades
					new_ability:Install( self, modifiers, self:SlotType( slot ) )
				else
					-- set level according to slot
					self.lock = true
					new_ability:SetLevel( self.levels[slot] )
					self.lock = false

					-- get old one (will not be to the left)
					local old_ability = self.slots[slot]
					local old_slot
					for i,v in pairs(self.slots) do
						if new_ability==v then
							old_slot = i
							break
						end
					end

					-- swap ability
					caster:SwapAbilities( 
						new_ability:GetAbilityName(),
						old_ability:GetAbilityName(),
						true,
						false
					)
					mark_for_deletion[old_ability] = true

					-- install upgrades
					new_ability:Install( self, modifiers, self:SlotType( slot ) )

					-- set references
					self.slots[slot] = new_ability
					if old_slot then
						self.slots[old_slot] = old_ability
					end
				end
			end
		end -- ability switch
	end -- ctr loop

	-- remove abilities marked as deleted
	for abil,_ in pairs(mark_for_deletion) do
		caster:RemoveAbilityByHandle( abil )
	end
end

--------------------------------------------------------------------------------
-- Helper
function red_transistor_access:SlotType( slot )
	local slot_type = "active"
	if slot==self.PASSIVE_SLOT then
		slot_type = "passive"
	end
	return slot_type
end

function red_transistor_access:Validate( list )
	local valid = true

	-- cant update if unit is dead
	if not self:GetCaster():IsAlive() then
		print("Invalid: Unit is dead.")
		return false
	end
	
	-- Assuming the length are the same
	local len1 = 0
	local len2 = 0
	for k,v in pairs(list) do
		len1 = len1+1
	end
	for k,v in pairs(self.list) do
		len2 = len2+1
	end

	if len1~=len2 then
		print("Invalid: Length is different:",len1,len2)
		return false
	end

	-- Rule 1: Locked stays locked
	for i,v in pairs(list) do
		if self.list[i]==17 and v~=17 then
			valid = false
			break
		end
	end
	if not valid then
		print("Invalid: Tried to unlock locked.")
		return false
	end

	-- Rule 2: No duplicates, except Empty and Locked
	for i=1,11 do
		if list[i]~=0 and list[i]~=17 then
			for j=i+1,12 do
				if list[i]==list[j] then
					valid = false
					break
				end
			end
			if not valid then break end
		end
	end
	if not valid then
		print("Invalid: Duplicates.")
		return false
	end

	return valid
end

function red_transistor_access:PrintStatus()
	print("PRINTSTATUS-----------------------------------")
	print("list")
	for k,v in pairs(self.list) do
		print("",k,v,self.ability_index[v])
	end
	print("levels")
	for k,v in pairs(self.levels) do
		print("",k,v)
	end
	print("abilities")
	for i=0,10 do
		local abil = self:GetCaster():GetAbilityByIndex( i )
		local name
		if abil then name = abil:GetAbilityName() end
		print("",i,abil,name)
	end
end

--------------------------------------------------------------------------------
-- Spell Start
function red_transistor_access:OnSpellStart()
	local caster = self:GetCaster()

	local senddata = {}
	senddata.list = self.list
	senddata.ability = self:entindex()
	senddata.playerID = self:GetCaster():GetPlayerOwnerID()
	senddata.open = 1
	CustomGameEventManager:Send_ServerToPlayer( caster:GetPlayerOwner(), "red_transistor_access", senddata )

	self:EndCooldown()
end

