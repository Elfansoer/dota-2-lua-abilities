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
outworld_devourer_arcane_orb_lua = class({})
LinkLuaModifier( "modifier_generic_orb_effect_lua", "lua_abilities/generic/modifier_generic_orb_effect_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_outworld_devourer_arcane_orb_lua", "lua_abilities/outworld_devourer_arcane_orb_lua/modifier_outworld_devourer_arcane_orb_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_outworld_devourer_arcane_orb_lua_stack", "lua_abilities/outworld_devourer_arcane_orb_lua/modifier_outworld_devourer_arcane_orb_lua_stack", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function outworld_devourer_arcane_orb_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

--------------------------------------------------------------------------------
-- Ability Start
function outworld_devourer_arcane_orb_lua:OnSpellStart()
end

--------------------------------------------------------------------------------
-- Orb Effects
function outworld_devourer_arcane_orb_lua:GetProjectileName()
	return "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_arcane_orb.vpcf"
end

function outworld_devourer_arcane_orb_lua:OnOrbFire( params )
	-- play effects
	local sound_cast = "Hero_ObsidianDestroyer.ArcaneOrb"
	EmitSoundOn( sound_cast, self:GetCaster() )
end

function outworld_devourer_arcane_orb_lua:OnOrbImpact( params )
	local caster = self:GetCaster()

	-- get data
	local duration = self:GetSpecialValueFor( "int_steal_duration" )
	local steal = self:GetSpecialValueFor( "int_steal" )
	local mana_pool = self:GetSpecialValueFor( "mana_pool_damage_pct" )
	local radius = self:GetSpecialValueFor( "radius" )

	-- precache damage
	local damage = caster:GetMana() * mana_pool/100
	local damageTable = {
		-- victim = target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- find enemies
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		params.target:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- damage
		damageTable.victim = enemy
		ApplyDamage( damageTable )

		-- overhead event
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_BONUS_SPELL_DAMAGE,
			enemy,
			damageTable.damage,
			nil
		)
	end

	-- add debuff
	params.target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_outworld_devourer_arcane_orb_lua", -- modifier name
		{
			duration = duration,
			steal = steal,
		} -- kv
	)

	-- add buff
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_outworld_devourer_arcane_orb_lua", -- modifier name
		{
			duration = duration,
			steal = steal,
		} -- kv
	)

	-- play effects
	local sound_cast = "Hero_ObsidianDestroyer.ArcaneOrb.Impact"
	EmitSoundOn( sound_cast, params.target )
end