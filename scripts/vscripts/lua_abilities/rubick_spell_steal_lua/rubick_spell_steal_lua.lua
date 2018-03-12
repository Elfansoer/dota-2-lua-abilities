rubick_spell_steal_lua = class({})
LinkLuaModifier( "modifier_rubick_spell_steal_lua", "lua_abilities/rubick_spell_steal_lua/modifier_rubick_spell_steal_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_rubick_spell_steal_lua_hidden", "lua_abilities/rubick_spell_steal_lua/modifier_rubick_spell_steal_lua_hidden", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function rubick_spell_steal_lua:GetIntrinsicModifierName()
	return "modifier_rubick_spell_steal_lua_hidden"
end
--------------------------------------------------------------------------------
-- Ability Cast Filter
rubick_spell_steal_lua.failState = nil
function rubick_spell_steal_lua:CastFilterResultTarget( hTarget )
	-- print( hTarget, self:GetLastSpell( hTarget ) )
	if self:GetLastSpell( hTarget )==nil then
		self.failState = "nevercast"
		print("fail")
		return UF_FAIL_CUSTOM
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
function rubick_spell_steal_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

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
	projectile = ProjectileManager:CreateTrackingProjectile(info)

	-- Play effects
	local sound_cast = "Hero_Rubick.SpellSteal.Cast"
	EmitSoundOn( sound_cast, target )
end

function rubick_spell_steal_lua:OnProjectileHit( target, location )
	local steal_duration = self:GetSpecialValueFor("duration")

	-- Add modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_rubick_spell_steal_lua", -- modifier name
		{ duration = steal_duration } -- kv
	)

	local sound_cast = "Hero_Rubick.SpellSteal.Target"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Helper
rubick_spell_steal_lua.heroesData = {}
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

	self:PrintStatus()
end

function rubick_spell_steal_lua:GetLastSpell( hHero )
	-- find hero in list
	local heroData = nil
	for _,data in pairs(rubick_spell_steal_lua.heroesData) do
		print(IsServer(), hHero:GetUnitName(), hHero, data.handle, data.lastSpell)
		if data.handle==hHero then
			heroData = data
			break
		end
	end

	if heroData then
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