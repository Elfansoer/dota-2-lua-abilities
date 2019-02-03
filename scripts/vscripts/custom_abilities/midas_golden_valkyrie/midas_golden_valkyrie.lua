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
-- LinkLuaModifier( "modifier_midas_golden_valkyrie_passive", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie_passive", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_valkyrie_ambient", "custom_abilities/midas_golden_valkyrie/modifier_midas_golden_valkyrie_ambient", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Behavior
-- function midas_golden_valkyrie_a:GetBehavior()
-- 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
-- end
-- function midas_golden_valkyrie_b:GetBehavior()
-- 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
-- end
-- function midas_golden_valkyrie_c:GetBehavior()
-- 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
-- end

--------------------------------------------------------------------------------
-- Ability Start
midas_golden_valkyrie_a.summon = nil
function midas_golden_valkyrie_a:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")
	local idle = self:GetSpecialValueFor("idle_radius")/2
	local location = caster:GetOrigin() - idle*caster:GetRightVector()

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
	local location = caster:GetOrigin() + idle*caster:GetRightVector()

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
	if not midas_golden_valkyrie.init then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade("rheva")
end
function midas_golden_valkyrie_b:OnUpgrade()
	if not midas_golden_valkyrie.init then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade("alena")
end
function midas_golden_valkyrie_c:OnUpgrade()
	if not midas_golden_valkyrie.init then
		midas_golden_valkyrie:Initialize( self:GetCaster() )
	end

	midas_golden_valkyrie:OnUpgrade("moren")
end

--------------------------------------------------------------------------------
-- Combined
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
function midas_golden_valkyrie:Initialize( caster )
	self.init = true
	self.caster = caster
	self.ability = {
		["rheva"] = caster:FindAbilityByName( "midas_golden_valkyrie_a" ),
		["alena"] = caster:FindAbilityByName( "midas_golden_valkyrie_b" ),
		["moren"] = caster:FindAbilityByName( "midas_golden_valkyrie_c" ),
	}
	self.leveled_ability = {
		["rheva"] = false,
		["alena"] = false,
		["moren"] = false,
	}

	-- self.caster:AddNewModifier(
	-- 	self.caster, -- player source
	-- 	self.ability["rheva"], -- ability source
	-- 	"modifier_midas_golden_valkyrie_passive", -- modifier name
	-- 	{  } -- kv
	-- )
end

midas_golden_valkyrie.upgrade_lock = false
function midas_golden_valkyrie:OnUpgrade( name )
	-- check upgrade lock
	if self.upgrade_lock then return end

	-- lock upgrade to prevent recursive call
	self.upgrade_lock = true

	-- check leveled
	if self.leveled_ability[name] then
		-- already leveled
		self.ability[name]:SetLevel( self.ability[name]:GetLevel()-1 )
		self.caster:SetAbilityPoints( self.caster:GetAbilityPoints()+1 )
	else
		-- level up
		local ability = self.ability[name]
		self.leveled_ability[name] = true
		for k,v in pairs(self.leveled_ability) do
			-- level up others
			if k~=name then
				self.ability[k]:SetLevel( ability:GetLevel() )
			end

			-- only leveled abilities that are active
			self.ability[k]:SetActivated( self.leveled_ability[k] )
		end
	end

	-- unlock upgrade
	self.upgrade_lock = false
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