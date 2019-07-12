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
LinkLuaModifier( "modifier_timbersaw_chakram_lua", "lua_abilities/timbersaw_chakram_lua/modifier_timbersaw_chakram_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_timbersaw_chakram_lua_disarm", "lua_abilities/timbersaw_chakram_lua/modifier_timbersaw_chakram_lua_disarm", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_timbersaw_chakram_lua_thinker", "lua_abilities/timbersaw_chakram_lua/modifier_timbersaw_chakram_lua_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Main ability
--------------------------------------------------------------------------------
timbersaw_chakram_lua = class({})

-- register here for easy copy on scepter ability
timbersaw_chakram_lua.sub_name = "timbersaw_return_chakram_lua"
timbersaw_chakram_lua.scepter = 0

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function timbersaw_chakram_lua:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function timbersaw_chakram_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- create thinker
	local thinker = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_timbersaw_chakram_lua_thinker", -- modifier name
		{
			target_x = point.x,
			target_y = point.y,
			target_z = point.z,
			scepter = self.scepter,
		}, -- kv
		caster:GetOrigin(),
		caster:GetTeamNumber(),
		false
	)
	local modifier = thinker:FindModifierByName( "modifier_timbersaw_chakram_lua_thinker" )

	-- add return ability and swap
	local sub = caster:AddAbility( self.sub_name )
	sub:SetLevel( 1 )
	caster:SwapAbilities(
		self:GetAbilityName(),
		self.sub_name,
		false,
		true
	)

	-- register each other
	self.modifier = modifier
	self.sub = sub
	sub.modifier = modifier
	modifier.sub = sub

	-- play effects
	local sound_cast = "Hero_Shredder.Chakram.Cast"
	EmitSoundOn( sound_cast, caster )
end

function timbersaw_chakram_lua:OnUnStolen()
	if self.modifier and not self.modifier:IsNull() then
		-- return the chakram
		self.modifier:ReturnChakram()

		-- reset position
		self:GetCaster():SwapAbilities(
			self:GetAbilityName(),
			self.sub:GetAbilityName(),
			true,
			false
		)
	end
end

--------------------------------------------------------------------------------
-- Item Events
function timbersaw_chakram_lua:OnInventoryContentsChanged( params )
	local caster = self:GetCaster()

	-- get data
	local scepter = caster:HasScepter()
	local ability = caster:FindAbilityByName( "timbersaw_chakram_2_lua" )

	-- if there's no ability, why bother
	if not ability then return end

	ability:SetActivated( scepter )
	ability:SetHidden( not scepter )

	if ability:GetLevel()~=1 then
		ability:SetLevel( 1 )
	end
end

--------------------------------------------------------------------------------
-- Sub-ability
--------------------------------------------------------------------------------
timbersaw_return_chakram_lua = class({})

--------------------------------------------------------------------------------
-- Ability Start
function timbersaw_return_chakram_lua:OnSpellStart()
	if self.modifier and not self.modifier:IsNull() then
		self.modifier:ReturnChakram()
	end
end

--------------------------------------------------------------------------------
-- Scepter-ability
--------------------------------------------------------------------------------
timbersaw_chakram_2_lua = class(timbersaw_chakram_lua)
timbersaw_chakram_2_lua.sub_name = "timbersaw_return_chakram_2_lua"
timbersaw_chakram_2_lua.scepter = 1
timbersaw_chakram_2_lua.OnInventoryContentsChanged = nil

timbersaw_return_chakram_2_lua = class(timbersaw_return_chakram_lua)