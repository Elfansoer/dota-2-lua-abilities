crystal_maiden_freezing_field_lua = class({})
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_lua", "lua_abilities/crystal_maiden_freezing_field_lua/modifier_crystal_maiden_freezing_field_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_crystal_maiden_freezing_field_lua_effect", "lua_abilities/crystal_maiden_freezing_field_lua/modifier_crystal_maiden_freezing_field_lua_effect", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function crystal_maiden_freezing_field_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- Add modifier
	self.modifier = caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_crystal_maiden_freezing_field_lua", -- modifier name
		{ duration = self:GetChannelTime() } -- kv
	)
end

--------------------------------------------------------------------------------
-- Ability Channeling
-- function crystal_maiden_freezing_field_lua:GetChannelTime()

-- end

function crystal_maiden_freezing_field_lua:OnChannelFinish( bInterrupted )
	if self.modifier then
		self.modifier:Destroy()
		self.modifier = nil
	end
end

--------------------------------------------------------------------------------
-- Ability Considerations
function crystal_maiden_freezing_field_lua:AbilityConsiderations()
	-- Scepter
	local bScepter = caster:HasScepter()

	-- Linken & Lotus
	local bBlocked = target:TriggerSpellAbsorb( self )

	-- Break
	local bBroken = caster:PassivesDisabled()

	-- Advanced Status
	local bInvulnerable = target:IsInvulnerable()
	local bInvisible = target:IsInvisible()
	local bHexed = target:IsHexed()
	local bMagicImmune = target:IsMagicImmune()

	-- Illusion Copy
	local bIllusion = target:IsIllusion()
end