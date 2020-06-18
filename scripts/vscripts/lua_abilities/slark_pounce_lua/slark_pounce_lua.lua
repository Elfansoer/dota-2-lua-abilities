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
slark_pounce_lua = class({})
LinkLuaModifier( "modifier_slark_pounce_lua", "lua_abilities/slark_pounce_lua/modifier_slark_pounce_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_slark_pounce_lua_debuff", "lua_abilities/slark_pounce_lua/modifier_slark_pounce_lua_debuff", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_arc_lua", "lua_abilities/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_leashed_lua", "lua_abilities/generic/modifier_generic_leashed_lua", LUA_MODIFIER_MOTION_BOTH )
LinkLuaModifier( "modifier_generic_charges", "lua_abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_BOTH )

--------------------------------------------------------------------------------
-- Passive Modifier
function slark_pounce_lua:GetIntrinsicModifierName()
	return "modifier_generic_charges"
end

--------------------------------------------------------------------------------
-- Ability Start
function slark_pounce_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- pounce
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_slark_pounce_lua", -- modifier name
		{} -- kv
	)

	-- play effects
	local sound_cast = "Hero_Slark.Pounce.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Events
function slark_pounce_lua:OnUpgrade()
	if not IsServer() then return end
	local caster = self:GetCaster()

	-- get charge modifier
	if not self.intrinsic then
		local modifiers = caster:FindAllModifiersByName( 'modifier_generic_charges' )
		for _,mod in pairs(modifiers) do
			if mod:GetAbility()==self then
				self.intrinsic = mod
			end
		end
	end
	if not self.intrinsic then return end

	-- set active
	self.intrinsic:SetActive( caster:HasScepter() )
end

function slark_pounce_lua:OnInventoryContentsChanged()
	-- same as when upgrading
	self:OnUpgrade()
end