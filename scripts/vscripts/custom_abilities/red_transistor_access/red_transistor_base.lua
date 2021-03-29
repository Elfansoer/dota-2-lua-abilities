-- Created by Elfansoer
--[[
- TEXTS
	Bounce
		ACTIVE: Releases a bolt that bounces against enemies and dealing damage.
		UPGRADE: Bounces or repeats the main function.
		PASSIVE: Damage reflect
	Breach
		ACTIVE: Shot a long distance arrow that deals damage.
		UPGRADE: Increases range of the main function.
		PASSIVE: Increases mana capacity.
	Crash
		ACTIVE: Stuns enemies along the path, dealing damage.
		UPGRADE: Stuns affected enemies.
		PASSIVE: Reduces damage taken.
	Flood
		ACTIVE: Creates a slow-moving sphere that deals damage over time.
		UPGRADE: Generates a lingering field that deals damage over time.
		PASSIVE: Increases health regeneration.
	Get
		ACTIVE: Shot a bolt that pulls the first enemy hit.
		UPGRADE: Add pull effect to affected enemies.
		PASSIVE: Grants attack modifier that slows enemies.
	Ping
		ACTIVE: Toggle on to rapidly shoot bolts that deals damage.
		UPGRADE: Reduces cooldown of the main function.
		PASSIVE: Increases attack speed.
	Purge
		ACTIVE: Shot a bolt that deals damage over time to a single target.
		UPGRADE: Deals damage per second to affected enemies.
		PASSIVE: Grants a slow effect on attacked enemies.
	Switch
		ACTIVE: Temporarily dominates the first enemy hit.
		UPGRADE: Add switch-allegiance effect to affected enemies.
		PASSIVE: Grants percentage stat bonus.
	Cull
		ACTIVE: Knocks upward enemies in the area.
		UPGRADE: Add knockback effect to affected enemies.
		PASSIVE: Grants a chance to bash attacked enemies.
	Help
		ACTIVE: Summons a friend that deals damage on area, which can be affected by modifiers.
		UPGRADE: Creates illusions that attacks affected enemies.
		PASSIVE: Grants a chance for critical strikes.
	Jaunt
		ACTIVE: Teleports and deals damage to the target area.
		UPGRADE: Reduces manacost of the main function.
		PASSIVE: Increases movement speed.
	Load
		ACTIVE: Creates a packet that deals area damage when attacked by anyone.
		UPGRADE: Deals damage in area around each affected enemies.
		PASSIVE: Increases attack damage.
	Mask
		ACTIVE: Turns user invisible, and deal bonus damage when attacks out of invisibility.
		UPGRADE: Deals backstab damage to affected enemies if user cannot be seen by them.
		PASSIVE: Grants a chance to evade attacks.
	Spark
		ACTIVE: Produces bolts which fans out from the point, dealing damage.
		UPGRADE: Splits the main function into 3 instances.
		PASSIVE: Grants cleave to attacks.
	Tap
		ACTIVE: Damages enemies in area around user, with a lifesteal effect.
		UPGRADE: Add lifesteal effect to the main function.
		PASSIVE: Increases health capacity
	Void
		ACTIVE: Adds damage amplification debuff to all enemies in area.
		UPGRADE: Add damage amp debuff to affected enemies for half the normal value.
		PASSIVE: Increases mana regeneration.
	Names
		Bounce(), 	 Niola Chein
		Breach(), 	 Unknown
		Crash(), 	 Red
		Cull(), 	 Olmarq
		Flood(), 	 Royce Bracket
		Get(), 		 Bailey Gilande
		Help(), 	 Sybil Reisz
		Jaunt(), 	 Preston Moyle
		Load(), 	 Wave Tennegan
		Mask(), 	 Shomar Shasberg
		Ping(), 	 Henter Jallaford
		Purge(), 	 Maximilias Darzi
		Spark(), 	 Lillian Platt
		Switch(), 	 Farrah Yon-Dale
		Tap(), 		 Grant Kendrell
		Void(), 	 Asher Kendrell

]]
--------------------------------------------------------------------------------
-- Base Ability
--------------------------------------------------------------------------------
generic_base = class({})
generic_base.modifiers = {}

--------------------------------------------------------------------------------
-- Init Abilities
function generic_base:Precache( context )
	-- PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_generic_base.vsndevts", context )
	-- PrecacheResource( "particle", "particles/units/heroes/hero_generic_base/generic_base.vpcf", context )
end

function generic_base:Spawn()
	if not IsServer() then return end
	self.modifiers = self.modifiers or {}
end

--------------------------------------------------------------------------------
-- Install/Uninstall
function generic_base:Install( access, name1, name2 )
	self.access = access
	self.kv = access.kv

	-- set access modifier (for client purposes)
	local caster = self:GetCaster()
	self.access_modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_access_modifiers", -- modifier name
		{} -- kv
	)

	-- set stack
	local id = access.ability_index[ self:GetAbilityName() ]
	local id1 = access.ability_index[ name1 ]
	local id2 = access.ability_index[ name2 ]
	local stack = 10000*id2 + 100*id1 + id
	self.access_modifier:SetStackCount( stack )

	-- -- 4th slot is passive
	-- if self.access.slots[4]==self then
	-- 	-- add passive modifier
	-- 	local passive = self:GetPassiveData()
	-- 	local mod = self:GetCaster():AddNewModifier(
	-- 		caster, -- player source
	-- 		self, -- ability source
	-- 		passive.name, -- modifier name
	-- 		passive.kv -- kv
	-- 	)

	-- 	self.passive = mod
	-- 	self.passive_mods = {}

	-- 	-- passive upgrades
	-- 	local passive = access.abilities[name1]:GetPassiveData()
	-- 	local mod = self:GetCaster():AddNewModifier(
	-- 		caster, -- player source
	-- 		self, -- ability source
	-- 		passive.name, -- modifier name
	-- 		passive.kv -- kv
	-- 	)
	-- 	self.passive[1] = mod

	-- 	local passive = access.abilities[name2]:GetPassiveData()
	-- 	local mod = self:GetCaster():AddNewModifier(
	-- 		caster, -- player source
	-- 		self, -- ability source
	-- 		passive.name, -- modifier name
	-- 		passive.kv -- kv
	-- 	)
	-- 	self.passive[2] = mod

	-- 	return
	-- end

	-- set install base
	self:InstallBase()

	if name1 then
		self.modifiers[1] = access.abilities[name1]
		self.modifiers[1]:ModifierInstall( self )
	end
	if name2 then
		self.modifiers[2] = access.abilities[name2]
		self.modifiers[2]:ModifierInstall( self )
	end
end

function generic_base:Uninstall()
	-- destroy access modifier
	if self.access_modifier and (not self.access_modifier:IsNull()) then
		self.access_modifier:Destroy()
		self.access_modifier = nil
	end

	-- -- passive
	-- if self.passive then
	-- 	if not self.passive:IsNull() then
	-- 		self.passive:Destroy()
	-- 		return
	-- 	end
	-- end

	for _,modifier in pairs(self.modifiers) do
		modifier:ModifierUninstall( self )
	end

	self.modifiers = {}

	-- set uninstall base
	self:UninstallBase()
end

function generic_base:Replace( access, name1, name2 )
	if name1 then
		self.modifiers[1]:ModifierUninstall( self )
		self.modifiers[1] = access.abilities[name1]
		self.modifiers[1]:ModifierInstall( self )

		-- update access modifier
		if self.access_modifier and (not self.access_modifier:IsNull()) then
			local stack = self.access_modifier:GetStackCount()
			local old_id = math.floor(stack/100)%100
			local id1 = access.ability_index[ name1 ]
			stack = stack - old_id*100 + id1*100
			self.access_modifier:SetStackCount( stack )
		end
	end
	if name2 then
		self.modifiers[2]:ModifierUninstall( self )
		self.modifiers[2] = access.abilities[name2]
		self.modifiers[2]:ModifierInstall( self )

		-- update access modifier
		if self.access_modifier and (not self.access_modifier:IsNull()) then
			local stack = self.access_modifier:GetStackCount()
			local old_id = math.floor(stack/10000)%100
			local id2 = access.ability_index[ name2 ]
			stack = stack - old_id*10000 + id2*10000
			self.access_modifier:SetStackCount( stack )
		end
	end
end

--------------------------------------------------------------------------------
-- Upgrade
function generic_base:OnUpgrade()
	if self.access and (not self.access.lock) then
		self.access:EventUpgrade( self )
	end
end

--------------------------------------------------------------------------------
-- Overridden functions
function generic_base:ProjectileLaunch( data ) end
function generic_base:ProjectileThink( loc, data ) end
function generic_base:ProjectileHit( target, loc, data ) end
function generic_base:ProjectileEnd( target, loc, data ) end

function generic_base:InstallBase() end
function generic_base:UninstallBase() end
function generic_base:ModifierInstall( this ) end
function generic_base:ModifierUninstall( this ) end

function generic_base:ModifierProjectileLaunch( this, data ) end
function generic_base:ModifierProjectileThink( this, loc, data ) end
function generic_base:ModifierProjectileHit( this, target, loc, data ) end
function generic_base:ModifierProjectileEnd( this, target, loc, data ) end

function generic_base:ModifierAreaStart( this, data ) end
function generic_base:ModifierAreaThink( this, loc, data ) end
function generic_base:ModifierAreaHit( this, target, loc, data ) end
function generic_base:ModifierAreaEnd( this, loc, data ) end

--------------------------------------------------------------------------------
-- Helper
function generic_base:GetAbilitySpecialValue( ability, name )
	local kv = self.kv[ability]["AbilitySpecial"]

	local specials = {}
	for _,v in pairs(kv) do
		for a,b in pairs(v) do
			if a~="var_type" then
				specials[a] = b
			end
		end
	end

	return specials[name] or 0
end