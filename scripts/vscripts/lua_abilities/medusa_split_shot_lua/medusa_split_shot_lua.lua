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
medusa_split_shot_lua = class({})
LinkLuaModifier( "modifier_medusa_split_shot_lua", "lua_abilities/medusa_split_shot_lua/modifier_medusa_split_shot_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function medusa_split_shot_lua:GetIntrinsicModifierName()

	-- Default is using attack modifier for meme reasons with moon glaive
	return "modifier_medusa_split_shot_lua"
end

--------------------------------------------------------------------------------
-- Projectile
function medusa_split_shot_lua:OnProjectileHit( target, location )
	if not target then return end

	-- perform attack
	self.split_shot_attack = true
	self:GetCaster():PerformAttack(
		target, -- hTarget
		false, -- bUseCastAttackOrb
		false, -- bProcessProcs
		true, -- bSkipCooldown
		false, -- bIgnoreInvis
		false, -- bUseProjectile
		false, -- bFakeAttack
		false -- bNeverMiss
	)
	self.split_shot_attack = false
end