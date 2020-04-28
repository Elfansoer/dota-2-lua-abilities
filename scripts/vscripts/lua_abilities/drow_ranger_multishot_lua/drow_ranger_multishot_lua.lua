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
drow_ranger_multishot_lua = class({})
LinkLuaModifier( "modifier_drow_ranger_multishot_lua", "lua_abilities/drow_ranger_multishot_lua/modifier_drow_ranger_multishot_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
drow_ranger_multishot_lua.targets = {}
function drow_ranger_multishot_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetChannelTime()

	self.targets = {}

	-- add modifier
	self.modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_drow_ranger_multishot_lua", -- modifier name
		{
			duration = duration,
			x = point.x,
			y = point.y,
			z = point.z,
		} -- kv
	)

end
--------------------------------------------------------------------------------
-- Projectile
function drow_ranger_multishot_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	-- check if already attacked on this wave
	if self.targets[ target ]==data.wave then return false end
	self.targets[ target ] = data.wave

	-- get value
	local damage = self:GetSpecialValueFor( "arrow_damage_pct" )
	local slow = self:GetSpecialValueFor( "arrow_slow_duration" )

	-- check frost arrow ability
	if data.frost==1 then
		local ability = self:GetCaster():FindAbilityByName( "drow_ranger_frost_arrows_lua" )
		target:AddNewModifier(
			self:GetCaster(), -- player source
			ability, -- ability source
			"modifier_drow_ranger_frost_arrows_lua", -- modifier name
			{ duration = slow } -- kv
		)
	end

	-- damage
	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetCaster():GetAttackDamage(),
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self, --Optional.
		-- damage_flags = DOTA_DAMAGE_FLAG_NONE, --Optional.
	}
	ApplyDamage(damageTable)

	-- play effects
	local sound_cast = "Hero_DrowRanger.ProjectileImpact"
	EmitSoundOn( sound_cast, target )

	return true
end

--------------------------------------------------------------------------------
-- Ability Channeling
function drow_ranger_multishot_lua:OnChannelFinish( bInterrupted )
	-- destroy modifier
	if not self.modifier:IsNull() then self.modifier:Destroy() end
end