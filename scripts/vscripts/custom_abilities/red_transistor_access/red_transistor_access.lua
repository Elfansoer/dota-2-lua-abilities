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
	- Replace install uninstall by loop instead of hardcode name1 name2
	- set cast range as abilityspecial
	- "Modifier" to "Upgrade"
	- mark for deletion delayed by existing projectiles/buffs
- not in progress
	- help upgrade concept (illusion is not good)
- next
	breach castrange
		- help and mask left
	rework abilities
		crash vs cull, switch, get, ping
	delete after no refcount
	onstolen
	multiple same hero
]]

require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_base" )
require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_projectile" )
require( "scripts/vscripts/custom_abilities/red_transistor_access/red_transistor_area" )

--------------------------------------------------------------------------------
-- Game Modifiers
LinkLuaModifier( "modifier_red_transistor_access_modifiers", "custom_abilities/red_transistor_access/modifier_red_transistor_access_modifiers", LUA_MODIFIER_MOTION_NONE )

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
	if not IsServer() then return end
	self:SetLevel( 1 )

	-- get ability references
	self.abilities = abilities
	self.ability_index = ability_index
	self.kv = LoadKeyValues( "scripts/npc/npc_abilities_custom.txt" )
	for k,v in pairs(self.kv) do
		if not self.ability_index[k] then
			self.kv[k] = nil
		end
	end

	-- set initial states as locked
	self.list = {}
	for i=1,12 do
		self.list[i] = 17
	end

	-- set abilities levels as 0
	self.levels = {}
	for i=1,4 do
		self.levels[i] = 0
	end

	-- get slot handles
	self.slots = {}
	self.slots[1] = self:GetCaster():FindAbilityByName( "red_transistor_locked_1" )
	self.slots[2] = self:GetCaster():FindAbilityByName( "red_transistor_locked_2" )
	self.slots[3] = self:GetCaster():FindAbilityByName( "red_transistor_locked_3" )
	self.slots[4] = self:GetCaster():FindAbilityByName( "red_transistor_locked_4" )

	-- initialize abilities
	for _,ability in pairs(self.slots) do
		ability:Install( self, "red_transistor_locked", "red_transistor_locked" )
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
	self.list[ ctr*3 + ability:GetLevel()] = 0

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
		empty:Install( self, "red_transistor_locked", "red_transistor_locked" )

		-- set reference
		self.slots[slot] = empty

		-- remove locked
		ability:Uninstall()
		caster:RemoveAbilityByHandle( ability )
	elseif level==2 then
		-- change locked upgrade to empty upgrade
		ability:Replace( self, "red_transistor_empty", nil )
	elseif level==3 then
		ability:Replace( self, nil, "red_transistor_empty" )
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
	for ctr=0,3 do
		-- layout is main-up1-up2-main-up1-...
		local slot = ctr+1
		local i = ctr*3 + 1
		local new_ability_index = list[i]
		local new_ability_name = self.ability_index[new_ability_index]
		local modifier1 = self.ability_index[list[i+1]]
		local modifier2 = self.ability_index[list[i+2]]
		print(i,"new_ability",self.ability_index[new_ability_index])

		-- Assume not locked nor empty
		if new_ability_index==17 then
		-- Locked ability
			-- Locked do not change anything. Reinstall.
			self.slots[slot]:Install( self, modifier1, modifier2 )

		elseif new_ability_index==0 then
		-- Empty ability

			if self.list[i]==0 then
				-- previously also empty. Reinstall.
				self.slots[slot]:Install( self, modifier1, modifier2 )
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
				new_ability:Install( self, modifier1, modifier2 )

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
				new_ability:Install( self, modifier1, modifier2 )

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
					new_ability:Install( self, modifier1, modifier2 )
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
					new_ability:Install( self, modifier1, modifier2 )

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
function red_transistor_access:Validate( list )
	local valid = true
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

	-- -- TEST LIST
	-- print("TEST LIST")
	-- local mocklist = {}
	-- local available = { 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 }

	-- -- set mains
	-- for i=0,3 do
	-- 	local idx = i*3+1
	-- 	local get = RandomInt( 1, #available )
	-- 	local ability = available[get]
	-- 	table.remove( available, get )
	-- 	mocklist[idx] = ability
	-- end
	-- -- set modifiers
	-- for i=1,12 do
	-- 	if i==1 or i==4 then
	-- 	else
	-- 		local get = RandomInt( 1, #available )
	-- 		local ability = available[get]
	-- 		table.remove( available, get )
	-- 		mocklist[i] = ability
	-- 	end
	-- end
	-- -- set locked
	-- for k,v in pairs(mocklist) do
	-- 	if self.list[k]==17 then mocklist[k] = 17 end
	-- end

	-- for k,v in pairs(mocklist) do
	-- 	print("",k,v,self.ability_index[v])
	-- end

	-- local data = {}
	-- data.list = mocklist
	-- data.ability = self:entindex()
	-- -- self.EventConfirm( self:GetCaster():GetPlayerOwnerID(), data )
end

