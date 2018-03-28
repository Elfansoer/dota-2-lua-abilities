bakedanuki_tricksters_insight = class({})
LinkLuaModifier( "modifier_bakedanuki_tricksters_insight", "custom_abilities/bakedanuki_tricksters_insight/modifier_bakedanuki_tricksters_insight", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_bakedanuki_tricksters_insight_passive", "custom_abilities/bakedanuki_tricksters_insight/modifier_bakedanuki_tricksters_insight_passive", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function bakedanuki_tricksters_insight:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb( self ) then
		return
	end

	-- load data
	local bDuration = self:GetSpecialValueFor("crit_duration")

	-- Add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bakedanuki_tricksters_insight_passive", -- modifier name
		{ duration = bDuration } -- kv
	)
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_bakedanuki_tricksters_insight", -- modifier name
		{ duration = bDuration } -- kv
	)

	self:PlayEffects( target )
end

--------------------------------------------------------------------------------
-- Ability Considerations
function bakedanuki_tricksters_insight:AbilityConsiderations()
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

--------------------------------------------------------------------------------
function bakedanuki_tricksters_insight:PlayEffects( target )
	-- Get Resources
	local sound_cast = "Hero_DarkWillow.Shadow_Realm.Damage"


	EmitSoundOn( sound_cast, target )
end