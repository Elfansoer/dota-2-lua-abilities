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
lion_mana_drain_lua = class({})
LinkLuaModifier( "modifier_lion_mana_drain_lua", "lua_abilities/lion_mana_drain_lua/modifier_lion_mana_drain_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
lion_mana_drain_lua.modifiers = {}
function lion_mana_drain_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then
		caster:Interrupt()
		return
	end

	-- load data
	local duration = self:GetChannelTime()

	-- register modifier (in case for multi-target)
	local modifier = target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_lion_mana_drain_lua", -- modifier name
		{ duration = duration } -- kv
	)
	self.modifiers[modifier] = true

	-- play effects
	self.sound_cast = "Hero_Lion.ManaDrain"
	EmitSoundOn( self.sound_cast, caster )
end

function lion_mana_drain_lua:OnChannelFinish( bInterrupted )
	-- destroy all modifier
	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier.forceDestroy = bInterrupted
			modifier:Destroy()
		end
	end
	self.modifiers = {}

	-- end sound
	StopSoundOn( self.sound_cast, self:GetCaster() )
end

function lion_mana_drain_lua:Unregister( modifier )
	-- unregister modifier
	self.modifiers[modifier] = nil

	-- check if there are no modifier left
	local counter = 0
	for modifier,_ in pairs(self.modifiers) do
		if not modifier:IsNull() then
			counter = counter+1
		end
	end

	-- stop channelling if no other target exist
	if counter==0 and self:IsChanneling() then
		self:EndChannel( false )
	end
end