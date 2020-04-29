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
modifier_underlord_pit_of_malice_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_underlord_pit_of_malice_lua:IsHidden()
	return false
end

function modifier_underlord_pit_of_malice_lua:IsDebuff()
	return true
end

function modifier_underlord_pit_of_malice_lua:IsStunDebuff()
	return false
end

function modifier_underlord_pit_of_malice_lua:IsPurgable()
	return true
end

function modifier_underlord_pit_of_malice_lua:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_underlord_pit_of_malice_lua:OnCreated( kv )
	-- references
	local interval = self:GetAbility():GetSpecialValueFor( "pit_interval" )

	if not IsServer() then return end

	-- create cooldown modifier
	self:GetParent():AddNewModifier(
		self:GetCaster(), -- player source
		self:GetAbility(), -- ability source
		"modifier_underlord_pit_of_malice_lua_cooldown", -- modifier name
		{
			duration = interval,
		} -- kv
	)

	-- play effects
	local hero = self:GetParent():IsHero()
	local sound_cast = "Hero_AbyssalUnderlord.Pit.TargetHero"
	if not hero then
		sound_cast = "Hero_AbyssalUnderlord.Pit.Target"
	end
	EmitSoundOn( sound_cast, self:GetParent() )

end

function modifier_underlord_pit_of_malice_lua:OnRefresh( kv )
	
end

function modifier_underlord_pit_of_malice_lua:OnRemoved()
end

function modifier_underlord_pit_of_malice_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_underlord_pit_of_malice_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_underlord_pit_of_malice_lua:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf"
end

function modifier_underlord_pit_of_malice_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end