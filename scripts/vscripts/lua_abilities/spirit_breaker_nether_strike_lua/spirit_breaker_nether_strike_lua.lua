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
spirit_breaker_nether_strike_lua = class({})
LinkLuaModifier( "modifier_spirit_breaker_nether_strike_lua", "lua_abilities/spirit_breaker_nether_strike_lua/modifier_spirit_breaker_nether_strike_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Init Abilities
function spirit_breaker_nether_strike_lua:Precache( context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
end

function spirit_breaker_nether_strike_lua:Spawn()
	if not IsServer() then return end
end

--------------------------------------------------------------------------------
-- Ability Phase Start
function spirit_breaker_nether_strike_lua:OnAbilityPhaseStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetCastPoint()

	-- add vision modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_spirit_breaker_nether_strike_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_Spirit_Breaker.NetherStrike.Begin"
	EmitSoundOn( sound_cast, self:GetCaster() )

	return true -- if success
end

function spirit_breaker_nether_strike_lua:OnAbilityPhaseInterrupted()
	local target = self:GetCursorTarget()

	-- delete vision modifier
	local mod = target:FindModifierByName( "modifier_spirit_breaker_nether_strike_lua" )
	if mod then mod:Destroy() end

	-- stop effects
	local sound_cast = "Hero_Spirit_Breaker.NetherStrike.Begin"
	StopSoundOn( sound_cast, self:GetCaster() )
end

--------------------------------------------------------------------------------
-- Ability Start
function spirit_breaker_nether_strike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local damage = self:GetSpecialValueFor( "damage" )
	local offset = 54

	-- get direction
	local direction = target:GetOrigin()-caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	-- set pos
	local pos = target:GetOrigin() + direction*offset
	caster:SetOrigin( pos )

	-- proc bash
	local mod = caster:FindModifierByName( "modifier_spirit_breaker_greater_bash_lua" )
	if mod and mod:GetAbility():GetLevel()>0 then
		mod:Bash( target, true )
	end

	-- apply damage
	local damageTable = {
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	FindClearSpaceForUnit( caster, pos, true )

	-- play effects
	local sound_cast = "Hero_Spirit_Breaker.NetherStrike.End"
	EmitSoundOn( sound_cast, caster )
end