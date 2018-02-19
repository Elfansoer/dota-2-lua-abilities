template = class({})
LinkLuaModifier( "modifier_template", "lua_abilities/template/modifier_template", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function template:GetIntrinsicModifierName()
	return "modifier_template"
end

--------------------------------------------------------------------------------
-- AOE Radius
function template:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function template:CastFilterResultTarget( hTarget )
	return UF_SUCCESS
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function template:OnAbilityPhaseInterrupted()

end
function template:OnAbilityPhaseStart()
	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function template:OnSpellStart()
	-- unit identifier
	caster = self:GetCaster()
	target = self:GetCursorTarget()
	point = self:GetCursorPosition()

	-- load data
	self.value1 = self:GetSpecialValueFor("some_value")

	-- Add modifier
	playerHero:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_some_modifier_lua", -- modifier name
		{ duration = bolt_stun_duration } -- kv
	)

	-- Apply Damage	 
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = 500,
		damage_type = DAMAGE_TYPE_PURE,
		damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	-- Create Projectile
	local info = {
		Target = target,
		Source = caster,
		Ability = caster:GetAbilityByIndex(0),	
		EffectName = "some_particle_effect",
		iMoveSpeed = 400,
		vSourceLoc= caster:GetAbsOrigin(),                -- Optional (HOW)
		bDrawsOnMinimap = false,                          -- Optional
		bDodgeable = true,                                -- Optional
		bIsAttack = false,                                -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bReplaceExisting = false,                         -- Optional
		flExpireTime = GameRules:GetGameTime() + 10,      -- Optional but recommended
		bProvidesVision = true,                           -- Optional
		iVisionRadius = 400,                              -- Optional
		iVisionTeamNumber = caster:GetTeamNumber()        -- Optional
	}
	projectile = ProjectileManager:CreateTrackingProjectile(info)

	-- Find Units in Radius
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),	-- int, your team number
		hTarget:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		bolt_aoe,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)
	
	-- Purge
	caster:Purge(bool bRemovePositiveBuffs, bool bRemoveDebuffs, bool bFrameOnly, bool bRemoveStuns, bool bRemoveExceptions)
end

--------------------------------------------------------------------------------
-- Ability Channeling
function template:GetChannelTime()

end

function template:OnChannelFinish( bInterrupted )

end

--------------------------------------------------------------------------------
-- Hero Events
function template:OnOwnerSpawned()

end

function template:OnOwnerDied()

end

function template:OnHeroLevelUp()

end

function template:OnHeroCalculateStatBonus()

end

--------------------------------------------------------------------------------
-- Ability Events
function template:OnUpgrade()

end

--------------------------------------------------------------------------------
-- Item Events
function template:OnInventoryContentsChanged()

end

function template:OnItemEquipped(handle hItem)

end

--------------------------------------------------------------------------------
-- Other Events
function template:OnHeroDiedNearby(handle unit, handle attacker, handle table)

end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function template:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function template:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function template:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function template:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

-- Helper: Flag operations
function template:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function template:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function template:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

-- Helper: Bitwise operations
function template:BitXOR(a,b)--Bitwise xor
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

function template:BitOR(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function template:BitNOT(n)
    local p,c=1,0
    while n>0 do
        local r=n%2
        if r<1 then c=c+p end
        n,p=(n-r)/2,p*2
    end
    return c
end

function template:BitAND(a,b)--Bitwise and
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>1 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end
