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
		PASSIVE: GGrants attack modifier that reduces enemy's armor.
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
generic_base.passive_name = "modifier_red_transistor_access_modifiers"

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

function generic_base:GetBehavior()
	if self.passive then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return self.BaseClass.GetBehavior( self )
end

function generic_base:GetCooldown( iLevel )
	if self.passive then
		return 0
	end
	return self.BaseClass.GetCooldown( self, iLevel )
end

function generic_base:GetManaCost( iLevel )
	if self.passive then
		return 0
	end
	return self.BaseClass.GetManaCost( self, iLevel )
end

--------------------------------------------------------------------------------
-- Install/Uninstall
function generic_base:Install( access, modifiers, slot_type )
	self.access = access
	self.kv = access.kv
	self.slot_type = slot_type

	if slot_type=="passive" then
		-- set install base
		self:InstallPassive()

		-- modifier installs
		for i,id in ipairs(modifiers) do
			self.modifiers[i] = self:ModifierInstallPassive( access.ability_index[ id ] )
		end
	else
		-- set install base
		self:InstallBase()

		-- modifier installs
		for i,id in ipairs(modifiers) do
			self.modifiers[i] = access.abilities[ access.ability_index[ id ] ]
			self.modifiers[i]:ModifierInstall( self )
		end
	end

	-- set access modifier (for client purposes)
	local caster = self:GetCaster()
	self.access_modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_red_transistor_access_modifiers", -- modifier name
		{ slot_type = slot_type } -- kv
	)

	-- set stack
	table.insert( modifiers, 1, access.ability_index[ self:GetAbilityName() ] )
	local stack = 0
	for i,id in pairs(modifiers) do
		stack = stack + id * 100^(i-1)
	end
	self.access_modifier:SetStackCount( stack )
end

function generic_base:Uninstall()
	-- destroy access modifier
	if self.access_modifier and (not self.access_modifier:IsNull()) then
		self.access_modifier:Destroy()
		self.access_modifier = nil
	end

	if self.slot_type=="passive" then
		-- modifier uninstalls
		for _,modifier in pairs(self.modifiers) do
			self:ModifierUninstallPassive( modifier )
		end

		-- set uninstall base
		self:UninstallPassive()
	else
		-- modifier uninstalls
		for _,modifier in pairs(self.modifiers) do
			modifier:ModifierUninstall( self )
		end

		-- set uninstall base
		self:UninstallBase()
	end

	self.modifiers = {}
end

function generic_base:Replace( access, index, name )
	if self.slot_type=="passive" then
		-- install uninstall
		self:ModifierUninstallPassive( self.modifiers[index] )
		self.modifiers[index] = self:ModifierInstallPassive( name )
	else
		-- install uninstall
		self.modifiers[index]:ModifierUninstall( self )
		self.modifiers[index] = access.abilities[ name ]
		self.modifiers[index]:ModifierInstall( self )
	end

	-- update access modifier
	if self.access_modifier and (not self.access_modifier:IsNull()) then
		local stack = self.access_modifier:GetStackCount()
		local div = 100^(index)

		local old_id = math.floor(stack/div)%100 * div
		local new_id = access.ability_index[ name ] * div

		stack = stack - old_id + new_id
		self.access_modifier:SetStackCount( stack )
	end
end

function generic_base:InstallPassive()
	local name = self.access.passive_name[self:GetAbilityName()]

	self.passive_mod = self:GetCaster():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		name, -- modifier name
		{} -- kv
	)
end

function generic_base:UninstallPassive()
	if self.passive_mod and (not self.passive_mod:IsNull()) then
		self.passive_mod:Destroy()
	end
end

function generic_base:ModifierInstallPassive( modifiername )
	local name = self.access.passive_name[ modifiername ]
	local mod = self:GetCaster():AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		name, -- modifier name
		{} -- kv
	)
	return mod
end

function generic_base:ModifierUninstallPassive( mod )
	if mod and (not mod:IsNull()) then
		mod:Destroy()
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
	if IsClient() and not self.kv then
		local access = self:GetCaster():FindAbilityByName( "red_transistor_access" )
		if not access then return 0 end
		self.kv = access.kv
	end

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