lich_chain_frost_lua = class({})
LinkLuaModifier( "modifier_lich_chain_frost_lua", "lua_abilities/lich_chain_frost_lua/modifier_lich_chain_frost_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function lich_chain_frost_lua:GetIntrinsicModifierName()
	return "modifier_lich_chain_frost_lua"
end

--------------------------------------------------------------------------------
-- Custom KV
function lich_chain_frost_lua:GetCastRange( vLocation, hTarget )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cast_range_scepter" )
	end

	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

function lich_chain_frost_lua:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return self:GetSpecialValueFor( "cooldown_scepter" )
	end

	return self.BaseClass.GetCooldown( self, level )
end

--------------------------------------------------------------------------------
-- Ability Start
function lich_chain_frost_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damage = self:GetSpecialValueFor("damage")
	if caster:HasScepter() then
		damage = self:GetSpecialValueFor("damage_scepter")
	end

	local projectile_name = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_vision = self:GetSpecialValueFor("vision_radius")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = false,                           -- Optional
	
		bReplaceExisting = false,                         -- Optional
		
		bDrawsOnMinimap = false,                          -- Optional
		bVisibleToEnemies = true,                         -- Optional
		bProvidesVision = true,                           -- Optional
		iVisionRadius = projectile_vision,					-- Optional
		iVisionTeamNumber = caster:GetTeamNumber()        -- Optional
		ExtraData = {
			damage = damage,
			jumps = self:GetSpecialValueFor("jumps"),
			jump_range = self:GetSpecialValueFor("jump_range"),
			as_slow = self:GetSpecialValueFor("slow_attack_speed"),
			ms_slow = self:GetSpecialValueFor("slow_movement_speed"),
			slow_duration = self:GetSpecialValueFor("slow_duration"),
			scepter = caster:HasScepter(),
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)

end
--------------------------------------------------------------------------------
-- Projectile
function lich_chain_frost_lua:OnProjectileHit_ExtraData( target, location, kv )
	local bounce_delay = 0.2

	-- apply damage and slow
	if (not target:IsMagicImmune()) and (not target:IsInvulnerable()) then
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = kv.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		target:AddNewModifier(
			self:GetCaster(), -- player source
			self, -- ability source
			"modifier_lich_chain_frost_lua", -- modifier name
			{
				duration = kv.slow_duration,
				as_slow = kv.as_slow,
				ms_slow = kv.ms_slow,
			} -- kv
		)
	end

	-- bounce thinker
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_lich_chain_frost_lua_thinker", -- modifier name
		{
			duration = 0.2,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Considerations
function lich_chain_frost_lua:AbilityConsiderations()
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
function lich_chain_frost_lua:PlayEffects()
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
function lich_chain_frost_lua:GetChannelTime()

end

function lich_chain_frost_lua:OnChannelFinish( bInterrupted )

end

--------------------------------------------------------------------------------
-- Hero Events
function lich_chain_frost_lua:OnOwnerSpawned()

end

function lich_chain_frost_lua:OnOwnerDied()

end

function lich_chain_frost_lua:OnHeroLevelUp()

end

function lich_chain_frost_lua:OnHeroCalculateStatBonus()

end

--------------------------------------------------------------------------------
-- Ability Events
function lich_chain_frost_lua:OnUpgrade()

end

--------------------------------------------------------------------------------
-- Item Events
function lich_chain_frost_lua:OnInventoryContentsChanged()

end

function lich_chain_frost_lua:OnItemEquipped(handle hItem)

end

--------------------------------------------------------------------------------
-- Other Events
function lich_chain_frost_lua:OnHeroDiedNearby(handle unit, handle attacker, handle table)

end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function lich_chain_frost_lua:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function lich_chain_frost_lua:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function lich_chain_frost_lua:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function lich_chain_frost_lua:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

-- Helper: Flag operations
function lich_chain_frost_lua:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function lich_chain_frost_lua:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function lich_chain_frost_lua:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end

-- Helper: Bitwise operations
function lich_chain_frost_lua:BitXOR(a,b)--Bitwise xor
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

function lich_chain_frost_lua:BitOR(a,b)--Bitwise or
    local p,c=1,0
    while a+b>0 do
        local ra,rb=a%2,b%2
        if ra+rb>0 then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    return c
end

function lich_chain_frost_lua:BitNOT(n)
    local p,c=1,0
    while n>0 do
        local r=n%2
        if r<1 then c=c+p end
        n,p=(n-r)/2,p*2
    end
    return c
end

function lich_chain_frost_lua:BitAND(a,b)--Bitwise and
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