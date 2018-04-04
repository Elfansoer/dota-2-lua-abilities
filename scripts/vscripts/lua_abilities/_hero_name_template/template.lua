template = class({})
LinkLuaModifier( "modifier_template", "lua_abilities/template/modifier_template", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function template:GetIntrinsicModifierName()
	return "modifier_template"
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function template:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

function template:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function template:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function template:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
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
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local value1 = self:GetSpecialValueFor("some_value")

	-- logic

end
--------------------------------------------------------------------------------
-- Projectile
function template:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function template:AbilityConsiderations()
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
function template:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
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

function azura_shadowform:PrintTableRecursive( key, value, tab )
	-- abort deep recursive
	if tab>10 then
		print("quit")
		return
	end

	local tabText = ""
	for i=0,tab do
		tabText = tabText .. "\t"
	end

	print(tabText,key,value, type(value))
	if (type(value)=='table') then
		for k,v in pairs(value) do
			self:PrintTableRecursive( k, v, tab + 1)
		end
	end
end