sandra_sacrifice = class({})
LinkLuaModifier( "modifier_sandra_sacrifice", "custom_abilities/sandra_sacrifice/modifier_sandra_sacrifice", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sandra_sacrifice_master", "custom_abilities/sandra_sacrifice/modifier_sandra_sacrifice_master", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
function sandra_sacrifice:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		0,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function sandra_sacrifice:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function sandra_sacrifice:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("leash_duration")

	-- destroy previous cast
	local modifier = caster:FindModifierByNameAndCaster( "modifier_sandra_sacrifice", caster )
	if modifier then
		modifier:Destroy()
	end

	-- add slave modifier
	local master = self:AddATValue( target )
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_sandra_sacrifice", -- modifier name
		{
			duration = duration,
			master = master,
		} -- kv
	)
end

--------------------------------------------------------------------------------
-- Built-in functions
-- Helper: Ability Table (AT)
function sandra_sacrifice:GetAT()
	if self.abilityTable==nil then
		self.abilityTable = {}
	end
	return self.abilityTable
end

function sandra_sacrifice:GetATEmptyKey()
	local table = self:GetAT()
	local i = 1
	while table[i]~=nil do
		i = i+1
	end
	return i
end

function sandra_sacrifice:AddATValue( value )
	local table = self:GetAT()
	local i = self:GetATEmptyKey()
	table[i] = value
	return i
end

function sandra_sacrifice:RetATValue( key )
	local table = self:GetAT()
	local ret = table[key]
	table[key] = nil
	return ret
end

-- Helper: Flag operations
function sandra_sacrifice:FlagExist(a,b)--Bitwise Exist
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function sandra_sacrifice:FlagAdd(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a
	else
		return a+b
	end
end

function sandra_sacrifice:FlagMin(a,b)--Bitwise and
	if FlagExist(a,b) then
		return a-b
	else
		return a
	end
end