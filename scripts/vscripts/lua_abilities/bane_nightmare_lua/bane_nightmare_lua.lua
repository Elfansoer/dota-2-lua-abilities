-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior: Broken on Spell Steal Lua
]]
--------------------------------------------------------------------------------
bane_nightmare_lua = class({})
LinkLuaModifier( "modifier_bane_nightmare_lua", "lua_abilities/bane_nightmare_lua/modifier_bane_nightmare_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bane_nightmare_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	self.modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bane_nightmare_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- check end ability
	local end_ability = caster:FindAbilityByName( "bane_nightmare_end_lua" )
	if not end_ability then
		-- stolen
		end_ability = caster:AddAbility( "bane_nightmare_end_lua" )
		self.add = end_ability
	end
	end_ability:SetLevel( 1 )
	end_ability.parent = self

	-- set layout
	self:SetLayout( false )
end

function bane_nightmare_lua:EndNightmare( forced )
	-- remove modifier
	if forced then
		self.modifier:Destroy()
	end
	self.modifier = nil

	-- reset layout
	self:SetLayout( true )

	-- remove ability if stolen
	if self.add then
		self:GetCaster():RemoveAbility( "bane_nightmare_end_lua" )
	end
end

bane_nightmare_lua.layout_main = true
function bane_nightmare_lua:SetLayout( main )
	-- if different ability is shown, swap
	if self.layout_main~=main then
		local ability_main = "bane_nightmare_lua"
		local ability_sub = "bane_nightmare_end_lua"

		-- swap
		self:GetCaster():SwapAbilities( ability_main, ability_sub, main, (not main) )
		self.layout_main = main
	end
end

--------------------------------------------------------------------------------
-- Hero Events
function bane_nightmare_lua:OnOwnerDied()
	self:EndNightmare( true )
end

--------------------------------------------------------------------------------
-- Helper Ability
bane_nightmare_end_lua = class({})
function bane_nightmare_end_lua:OnSpellStart()
	self.parent:EndNightmare( true )
end