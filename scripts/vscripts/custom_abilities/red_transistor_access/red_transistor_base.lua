-- Created by Elfansoer

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

	if name1 then
		self.modifiers[1] = access.abilities[name1]
		self.modifiers[1]:ModifierInstall( self )
	end
	if name2 then
		self.modifiers[2] = access.abilities[name2]
		self.modifiers[2]:ModifierInstall( self )
	end

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

	-- set install base
	self:InstallBase()
end

function generic_base:Uninstall()
	for _,modifier in pairs(self.modifiers) do
		modifier:ModifierUninstall( self )
	end

	-- destroy access modifier
	if self.access_modifier and (not self.access_modifier:IsNull()) then
		self.access_modifier:Destroy()
		self.access_modifier = nil
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