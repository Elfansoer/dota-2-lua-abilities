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
modifier_dark_willow_bramble_maze_lua_debuff = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_dark_willow_bramble_maze_lua_debuff:IsHidden()
	return false
end

function modifier_dark_willow_bramble_maze_lua_debuff:IsDebuff()
	return true
end

function modifier_dark_willow_bramble_maze_lua_debuff:IsStunDebuff()
	return false
end

function modifier_dark_willow_bramble_maze_lua_debuff:IsPurgable()
	return true
end

function modifier_dark_willow_bramble_maze_lua_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_dark_willow_bramble_maze_lua_debuff:OnCreated( kv )

	if not IsServer() then return end
	-- references
	local duration = kv.duration
	local damage = kv.damage
	local interval = 0.5

	-- set dps
	local instances = duration/interval
	local dps = damage/instances

	-- precache damage
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = dps,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	-- ApplyDamage(damageTable)

	-- Start interval
	self:StartIntervalThink( interval )

	-- play effects
	local sount_cast1 = "Hero_DarkWillow.Bramble.Target"
	local sount_cast2 = "Hero_DarkWillow.Bramble.Target.Layer"
	EmitSoundOn( sount_cast1, self:GetParent() )
	EmitSoundOn( sount_cast2, self:GetParent() )
end

function modifier_dark_willow_bramble_maze_lua_debuff:OnRefresh( kv )
	
end

function modifier_dark_willow_bramble_maze_lua_debuff:OnRemoved()
end

function modifier_dark_willow_bramble_maze_lua_debuff:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_dark_willow_bramble_maze_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_dark_willow_bramble_maze_lua_debuff:OnIntervalThink()
	-- apply damage
	ApplyDamage( self.damageTable )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_dark_willow_bramble_maze_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_dark_willow/dark_willow_bramble.vpcf"
end

function modifier_dark_willow_bramble_maze_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end