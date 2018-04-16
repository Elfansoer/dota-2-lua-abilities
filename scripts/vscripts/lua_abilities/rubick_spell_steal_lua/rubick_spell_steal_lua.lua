rubick_spell_steal_lua = class({})
rubick_spell_steal_lua_slot1 = class({})
rubick_spell_steal_lua_slot2 = class({})
LinkLuaModifier( "modifier_rubick_spell_steal_lua", "lua_abilities/rubick_spell_steal_lua/modifier_rubick_spell_steal_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rubick_spell_steal_lua_hidden", "lua_abilities/rubick_spell_steal_lua/modifier_rubick_spell_steal_lua_hidden", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rubick_spell_steal_lua_animation", "lua_abilities/rubick_spell_steal_lua/modifier_rubick_spell_steal_lua_animation", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
rubick_spell_steal_lua.firstTime = true
function rubick_spell_steal_lua:OnHeroCalculateStatBonus()
	if self.firstTime then
		self:GetCaster():AddNewModifier(
			self:GetCaster(),
			self,
			"modifier_rubick_spell_steal_lua_hidden",
			{}
		)
		self.firstTime = false
	end
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
rubick_spell_steal_lua.failState = nil
function rubick_spell_steal_lua:CastFilterResultTarget( hTarget )
	if IsServer() then
		if self:GetLastSpell( hTarget )==nil then
			self.failState = "nevercast"
			return UF_FAIL_CUSTOM
		end
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function rubick_spell_steal_lua:GetCustomCastErrorTarget( hTarget )
	if self.failState and self.failState=="nevercast" then
		self.failState = nil
		return "#dota_hud_error_never_cast"
	end
	
	return ""
end
--------------------------------------------------------------------------------
-- Ability Phase Start
-- function rubick_spell_steal_lua:OnAbilityPhaseInterrupted()

-- end
-- function rubick_spell_steal_lua:OnAbilityPhaseStart()
-- 	return true -- if success
-- end

--------------------------------------------------------------------------------
-- Ability Start
rubick_spell_steal_lua.stolenSpell = nil
function rubick_spell_steal_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- Cancel if blocked
	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- Get last used spell
	self.stolenSpell = {}
	self.stolenSpell.lastSpell = self:GetLastSpell( target )

	-- load data
	local projectile_name = "particles/units/heroes/hero_rubick/rubick_spell_steal.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	-- Create Projectile
	local info = {
		Target = caster,
		Source = target,
		Ability = self,	
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		vSourceLoc = target:GetAbsOrigin(),                -- Optional (HOW)
		bDrawsOnMinimap = false,                          -- Optional
		bDodgeable = false,                                -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bReplaceExisting = false,                         -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Rubick.SpellSteal.Cast"
	EmitSoundOn( sound_cast, caster )
	local sound_target = "Hero_Rubick.SpellSteal.Target"
	EmitSoundOn( sound_target, target )
end

function rubick_spell_steal_lua:OnProjectileHit( target, location )
	-- Add ability
	self:SetStolenSpell( self.stolenSpell )
	self.stolenSpell = nil

	-- Add modifier
	local steal_duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_rubick_spell_steal_lua", -- modifier name
		{ duration = steal_duration } -- kv
	)

	local sound_cast = "Hero_Rubick.SpellSteal.Complete"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Helper: Heroes Data
rubick_spell_steal_lua.heroesData = {}
rubick_spell_steal_lua.interactions = require "lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_interaction_reference"
--[[
heroesData:
- data.handle = Hero handle
- data.lastSpell = Hero last spell
]]

function rubick_spell_steal_lua:SetLastSpell( hHero, hSpell )
	-- find hero in list
	local heroData = nil
	for _,data in pairs(rubick_spell_steal_lua.heroesData) do
		if data.handle==hHero then
			heroData = data
			break
		end
	end

	-- store data
	if heroData then
		heroData.lastSpell = hSpell
	else
		local newData = {}
		newData.handle = hHero
		newData.lastSpell = hSpell
		table.insert( rubick_spell_steal_lua.heroesData, newData )
	end

	-- self:PrintStatus()
end

function rubick_spell_steal_lua:GetLastSpell( hHero )
	-- find hero in list
	local heroData = nil
	for _,data in pairs(rubick_spell_steal_lua.heroesData) do
		if data.handle==hHero then
			heroData = data
			break
		end
	end

	if heroData then
		-- local table = {}
		-- table.lastSpell = heroData.lastSpell
		-- table.interaction = self.interactions.Init( table.lastSpell, self )
		-- return table
		return heroData.lastSpell
	end

	return nil
end

function rubick_spell_steal_lua:PrintStatus()
	print("Heroes and spells:")
	for _,heroData in pairs(rubick_spell_steal_lua.heroesData) do
		print( heroData.handle:GetUnitName(), heroData.handle, heroData.lastSpell:GetAbilityName(), heroData.lastSpell )
	end
end

--------------------------------------------------------------------------------
-- Helper: Current spell
rubick_spell_steal_lua.currentSpell = nil
rubick_spell_steal_lua.slot1 = "rubick_spell_steal_lua_slot1"
rubick_spell_steal_lua.slot2 = "rubick_spell_steal_lua_slot2"
rubick_spell_steal_lua.animations = require "lua_abilities/rubick_spell_steal_lua/rubick_spell_steal_animation_reference"

-- Add new stolen spell
function rubick_spell_steal_lua:SetStolenSpell( spellData )
	local spell = spellData.lastSpell
	local interaction = spellData.interaction

	-- Forget previous one
	self:ForgetSpell()

	-- Add new spell
	self.currentSpell = self:GetCaster():AddAbility( spell:GetAbilityName() )
	self.currentSpell:SetLevel( spell:GetLevel() )
	self.currentSpell:SetStolen( true )
	self:GetCaster():SwapAbilities( self.slot1, self.currentSpell:GetAbilityName(), false, true )

	-- Animations override
	self.animations:SetCurrentReference( self.currentSpell:GetAbilityName() )
	if not self.animations:IsNormal() and (not self:FlagExist( self.currentSpell:GetBehavior(), DOTA_ABILITY_BEHAVIOR_NORMAL_WHEN_STOLEN )) then
		self.currentSpell:SetOverrideCastPoint( 0.1 )
	end
end

-- Remove currently stolen spell
function rubick_spell_steal_lua:ForgetSpell()
	if self.currentSpell~=nil then
		self:GetCaster():SwapAbilities( self.slot1, self.currentSpell:GetAbilityName(), true, false )
		self:GetCaster():RemoveAbility( self.currentSpell:GetAbilityName() )
		self.currentSpell = nil
	end
end
--------------------------------------------------------------------------------
-- Ability Considerations
function rubick_spell_steal_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function rubick_spell_steal_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function rubick_spell_steal_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function rubick_spell_steal_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function rubick_spell_steal_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

function rubick_spell_steal_lua:DisplayAT()
	local table = self:GetAT()
	for k,v in pairs(table) do
		print(k,v)
	end
end

-- Helper: Flag operations
function rubick_spell_steal_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function rubick_spell_steal_lua:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function rubick_spell_steal_lua:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

-- Helper: Bitwise operations
function rubick_spell_steal_lua:BitXOR(a,b)--Bitwise xor
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
    return c
end

function rubick_spell_steal_lua:BitOR(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function rubick_spell_steal_lua:BitNOT(n)
    local p,c=1,0
    while n>0 do
        local r=n%2
        if r<1 then c=c+p end
        n,p=(n-r)/2,p*2
    end
    return c
end

function rubick_spell_steal_lua:BitAND(a,b)--Bitwise and
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end