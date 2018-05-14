lion_earth_spike_lua = class({})
LinkLuaModifier( "modifier_lion_earth_spike_lua", "lua_abilities/lion_earth_spike_lua/modifier_lion_earth_spike_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function lion_earth_spike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	local projectile_name = ""
	local projectile_distance = self:GetCastRange()
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    
	    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
	    iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
	    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_start_radius,
	    fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)
	-- logic

end
--------------------------------------------------------------------------------
-- Projectile
function lion_earth_spike_lua:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function lion_earth_spike_lua:AbilityConsiderations()
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
function lion_earth_spike_lua:PlayEffects()
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
function lion_earth_spike_lua:GetChannelTime()

end

function lion_earth_spike_lua:OnChannelFinish( bInterrupted )

end

--------------------------------------------------------------------------------
-- Hero Events
function lion_earth_spike_lua:OnOwnerSpawned()

end

function lion_earth_spike_lua:OnOwnerDied()

end

function lion_earth_spike_lua:OnHeroLevelUp()

end

function lion_earth_spike_lua:OnHeroCalculateStatBonus()

end

--------------------------------------------------------------------------------
-- Ability Events
function lion_earth_spike_lua:OnUpgrade()

end

--------------------------------------------------------------------------------
-- Item Events
function lion_earth_spike_lua:OnInventoryContentsChanged()

end

function lion_earth_spike_lua:OnItemEquipped(handle hItem)

end

--------------------------------------------------------------------------------
-- Other Events
function lion_earth_spike_lua:OnHeroDiedNearby(handle unit, handle attacker, handle table)

end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function lion_earth_spike_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function lion_earth_spike_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function lion_earth_spike_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function lion_earth_spike_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

-- Helper: Flag operations
function lion_earth_spike_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function lion_earth_spike_lua:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function lion_earth_spike_lua:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

-- Helper: Bitwise operations
function lion_earth_spike_lua:BitXOR(a,b)--Bitwise xor
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

function lion_earth_spike_lua:BitOR(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function lion_earth_spike_lua:BitNOT(n)
    local p,c=1,0
    while n>0 do
        local r=n%2
        if r<1 then c=c+p end
        n,p=(n-r)/2,p*2
    end
    return c
end

function lion_earth_spike_lua:BitAND(a,b)--Bitwise and
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