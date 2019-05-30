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
windranger_focus_fire_lua = class({})
LinkLuaModifier( "modifier_windranger_focus_fire_lua", "lua_abilities/windranger_focus_fire_lua/modifier_windranger_focus_fire_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function windranger_focus_fire_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetDuration()

	-- this version of Focus Fire allows multiple target
	-- check existing modifiers
	local found = false
	local modifiers = caster:FindAllModifiersByName( "modifier_windranger_focus_fire_lua" )
	for _,modifier in pairs(modifiers) do
		if modifier.target==target then
			-- if already exist for current target, refresh
			modifier:ForceRefresh()
			found = true
			break
		end
	end

	if not found then
		-- get entindex
		local ent = target:entindex()

		-- add modifier to new targets
		caster:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_windranger_focus_fire_lua", -- modifier name
			{
				duration = duration,
				target = ent,
			} -- kv
		)
	end

	-- Play effects
	local sound_cast = "Ability.Focusfire"
	EmitSoundOn( sound_cast, caster )
end