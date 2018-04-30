dark_willow_terrorize_lua = class({})
LinkLuaModifier( "modifier_dark_willow_terrorize_lua", "lua_abilities/dark_willow_terrorize_lua/modifier_dark_willow_terrorize_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function dark_willow_terrorize_lua:GetAOERadius()
	return self:GetSpecialValueFor( "destination_radius" )
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function dark_willow_terrorize_lua:OnAbilityPhaseInterrupted()
	self:StopEffects1()
end
function dark_willow_terrorize_lua:OnAbilityPhaseStart()
	local point = self:GetCursorPosition()
	local radius = self:GetSpecialValueFor( "destination_radius" )
	
	-- effects
	self:PlayEffects1( point, radius )

	return true -- if success
end

--------------------------------------------------------------------------------
-- Ability Start
function dark_willow_terrorize_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("destination_status_duration")
	local radius = self:GetSpecialValueFor("destination_radius")
	local projectile_speed = self:GetSpecialValueFor("destination_travel_speed")

	-- create projectile
	local projectile_name = ""
	local projectile_start_radius = 100
	local projectile_end_radius = 100
	local projectile_direction = (point-caster:GetOrigin()):Normalized()
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		
	    bDeleteOnHit = false,
	    	    
	    EffectName = projectile_name,
	    fDistance = projectile_distance,
	    fStartRadius = projectile_start_radius,
	    fEndRadius =projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,
		ExtraData = {
			start = true,
		}
	}
	ProjectileManager:CreateLinearProjectile(info)
end
--------------------------------------------------------------------------------
-- Projectile
function dark_willow_terrorize_lua:OnProjectileHit_ExtraData( target, location, kv )
	if kv.start then
		-- Find enemy in radius
	end
end

--------------------------------------------------------------------------------
-- Ability Considerations
function dark_willow_terrorize_lua:AbilityConsiderations()
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
function dark_willow_terrorize_lua:PlayEffects()
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
function dark_willow_terrorize_lua:GetChannelTime()

end

function dark_willow_terrorize_lua:OnChannelFinish( bInterrupted )

end

--------------------------------------------------------------------------------
-- Hero Events
function dark_willow_terrorize_lua:OnOwnerSpawned()

end

function dark_willow_terrorize_lua:OnOwnerDied()

end

function dark_willow_terrorize_lua:OnHeroLevelUp()

end

function dark_willow_terrorize_lua:OnHeroCalculateStatBonus()

end

--------------------------------------------------------------------------------
-- Ability Events
function dark_willow_terrorize_lua:OnUpgrade()

end

--------------------------------------------------------------------------------
-- Item Events
function dark_willow_terrorize_lua:OnInventoryContentsChanged()

end

function dark_willow_terrorize_lua:OnItemEquipped(handle hItem)

end

--------------------------------------------------------------------------------
-- Other Events
function dark_willow_terrorize_lua:OnHeroDiedNearby(handle unit, handle attacker, handle table)

end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function dark_willow_terrorize_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function dark_willow_terrorize_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function dark_willow_terrorize_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function dark_willow_terrorize_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

-- Helper: Flag operations
function dark_willow_terrorize_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function dark_willow_terrorize_lua:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function dark_willow_terrorize_lua:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

-- Helper: Bitwise operations
function dark_willow_terrorize_lua:BitXOR(a,b)--Bitwise xor
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

function dark_willow_terrorize_lua:BitOR(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function dark_willow_terrorize_lua:BitNOT(n)
    local p,c=1,0
    while n>0 do
        local r=n%2
        if r<1 then c=c+p end
        n,p=(n-r)/2,p*2
    end
    return c
end

function dark_willow_terrorize_lua:BitAND(a,b)--Bitwise and
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