-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
midas_golden_valkyrie_a = class({})
midas_golden_valkyrie_b = class({})
midas_golden_valkyrie_c = class({})
LinkLuaModifier( "modifier_midas_golden_valkyrie", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_valkyrie_buff", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie_buff", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_valkyrie_passive", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_valkyrie_ambient", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie_ambient", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Behavior
-- not using instance methods, but class methods
function midas_golden_valkyrie_a:GetBehavior()
	return midas_golden_valkyrie:GetBehavior( self, "rheva" )
end
function midas_golden_valkyrie_b:GetBehavior()
	return midas_golden_valkyrie:GetBehavior( self, "alena" )
end
function midas_golden_valkyrie_c:GetBehavior()
	return midas_golden_valkyrie:GetBehavior( self, "moren" )
end

--------------------------------------------------------------------------------
-- Ability Start
midas_golden_valkyrie_a.summon = nil
function midas_golden_valkyrie_a:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local idle = self:GetSpecialValueFor("idle_radius")/2
	local direction = RotatePosition( Vector(0,0,0), QAngle( 0, -120, 0 ), caster:GetForwardVector() )
	local location = caster:GetOrigin() + idle*direction

	-- summon
	midas_golden_valkyrie:SummonValkyrie( self, "rheva", location, duration )
end

midas_golden_valkyrie_b.summon = nil
function midas_golden_valkyrie_b:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local idle = self:GetSpecialValueFor("idle_radius")/2
	local direction = RotatePosition( Vector(0,0,0), QAngle( 0, 120, 0 ), caster:GetForwardVector() )
	local location = caster:GetOrigin() + idle*direction

	-- summon
	midas_golden_valkyrie:SummonValkyrie( self, "alena", location, duration )
end

midas_golden_valkyrie_c.summon = nil
function midas_golden_valkyrie_c:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local idle = self:GetSpecialValueFor("idle_radius")/2
	local location = caster:GetOrigin() + idle*caster:GetForwardVector()

	-- summon
	midas_golden_valkyrie:SummonValkyrie( self, "moren", location, duration )
end

--------------------------------------------------------------------------------
-- Ability Upgrade
function midas_golden_valkyrie_a:OnUpgrade()
	if not self.shared then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade( self, "rheva" )
end
function midas_golden_valkyrie_b:OnUpgrade()
	if not self.shared then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade( self, "alena")
end
function midas_golden_valkyrie_c:OnUpgrade()
	if not self.shared then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade( self, "moren" )
end

--------------------------------------------------------------------------------
-- Combined data
midas_golden_valkyrie = {}
midas_golden_valkyrie.init = false
midas_golden_valkyrie.unit_name = {
	["rheva"] = "npc_dota_midas_golden_valkyrie_a",
	["alena"] = "npc_dota_midas_golden_valkyrie_b",
	["moren"] = "npc_dota_midas_golden_valkyrie_c",
}
midas_golden_valkyrie.unit_style = {
	["rheva"] = 0,
	["alena"] = 1,
	["moren"] = 2,
}
midas_golden_valkyrie.ability_bit = {
	["rheva"] = 1,
	["alena"] = 2,
	["moren"] = 4,
}

function midas_golden_valkyrie:Initialize( caster )
	-- generate class data
	local copy = {}

	-- generate instance data
	copy.abilities = {
		["rheva"] = caster:FindAbilityByName( "midas_golden_valkyrie_a" ),
		["alena"] = caster:FindAbilityByName( "midas_golden_valkyrie_b" ),
		["moren"] = caster:FindAbilityByName( "midas_golden_valkyrie_c" ),
	}
	copy.passive = caster:AddNewModifier(
		caster, -- player source
		copy.abilities["rheva"], -- ability source
		"modifier_midas_golden_valkyrie_passive", -- modifier name
		{} -- kv
	)

	for name,ability in pairs(copy.abilities) do
		ability.shared = copy
	end
end

midas_golden_valkyrie.upgrade_lock = false
function midas_golden_valkyrie:OnUpgrade( ability, name )
	local shared = ability.shared

	-- check upgrade lock
	if shared.upgrade_lock then return end

	-- lock upgrade to prevent recursive call
	shared.upgrade_lock = true

	-- check leveled
	if shared.passive:HasBit( self.ability_bit[name] ) then
		-- already leveled
		ability:SetLevel( ability:GetLevel()-1 )
		ability:GetCaster():SetAbilityPoints( ability:GetCaster():GetAbilityPoints()+1 )
	else
		-- level up others
		for _,abil in pairs(shared.abilities) do
			if abil~=ability then
				abil:SetLevel( ability:GetLevel() )
			end
		end

		-- change behavior
		shared.passive:AddBit( self.ability_bit[name] )
	end

	-- unlock upgrade
	shared.upgrade_lock = false
end

function midas_golden_valkyrie:GetBehavior( ability, name )
	local stack = ability:GetCaster():GetModifierStackCount( "modifier_midas_golden_valkyrie_passive", ability:GetCaster() )

	-- flag operation
	if self:FlagExist( stack, self.ability_bit[name] ) then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE
end
function midas_golden_valkyrie:FlagExist(a,b)
	local p,c,d=1,0,b
	while a>0 and b>0 do
		local ra,rb=a%2,b%2
		if ra+rb>1 then c=c+p end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	return c==d
end

function midas_golden_valkyrie:SummonValkyrie( ability, name, location, duration )
	local caster = ability:GetCaster()

	if ability.summon then
		-- if already summoned
		ability.summon:ForceKill( false )
		ability.summon:RespawnUnit()
		FindClearSpaceForUnit( ability.summon, location, true )
	else
		-- summon for the first time
		local unit = CreateUnitByName(
			self.unit_name[name],
			location,
			true,
			caster,
			caster:GetOwner(),
			caster:GetTeamNumber()
		)
		FindClearSpaceForUnit( unit, location, true )
		unit:SetControllableByPlayer( caster:GetPlayerID(), false )
		unit:SetOwner( caster )
		unit:SetUnitCanRespawn( true )
		ability.summon = unit
	end
	local forward = ability.summon:GetOrigin()-caster:GetOrigin()
	forward.z = 0
	ability.summon:SetForwardVector( forward:Normalized() )
	ability.summon:AddNewModifier(
		caster, -- player source
		ability, -- ability source
		"modifier_midas_golden_valkyrie_ambient", -- modifier name
		{ style = self.unit_style[name] } -- kv
	)

	-- add duration modifier
	ability.summon:AddNewModifier(
		caster, -- player source
		ability, -- ability source
		"modifier_midas_golden_valkyrie", -- modifier name
		{ duration = duration } -- kv
	)

	--- add tooltip to caster
	-- destroy existing tooltip
	local modifiers = caster:FindAllModifiersByName( "modifier_midas_golden_valkyrie_buff" )
	for _,modifier in pairs(modifiers) do
		if modifier:GetAbility()==ability then
			modifier:Destroy()
		end
	end

	-- add tooltip modifier
	caster:AddNewModifier(
		caster, -- player source
		ability, -- ability source
		"modifier_midas_golden_valkyrie_buff", -- modifier name
		{ duration = duration } -- kv
	)
end