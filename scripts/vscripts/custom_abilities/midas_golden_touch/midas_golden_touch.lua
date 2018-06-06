midas_golden_touch = class({})
LinkLuaModifier( "modifier_midas_golden_touch", "custom_abilities/midas_golden_touch/modifier_midas_golden_touch", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_midas_golden_touch_thinker", "custom_abilities/midas_golden_touch/modifier_midas_golden_touch_thinker", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function midas_golden_touch:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	-- local target = self:GetCursorTarget()

	-- create thinker
	local statue = CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_midas_golden_touch_thinker", -- modifier name
		{ 
			duration = 5,
		}, -- kv
		caster:GetOrigin() - caster:GetForwardVector()*50,
		caster:GetTeamNumber(),
		true
	)
	-- local statue = CreateUnitByName( 
	-- 	"npc_dota_midas_golden_touch",
	-- 	target:GetAbsOrigin(),
	-- 	true,
	-- 	caster,
	-- 	caster:GetOwner(),
	-- 	caster:GetTeamNumber()
	-- )
	-- statue:AddNewModifier(
	-- 	caster, -- player source
	-- 	self, -- ability source
	-- 	"modifier_midas_golden_touch", -- modifier name
	-- 	{ duration = 5,
	-- 	pose = target:GetSequence() } -- kv
	-- )

	-- set status
	-- statue:SetHullRadius( target:GetHullRadius() )
	-- statue:SetModel( target:GetModelName() )
	-- statue:SetModelScale( target:GetModelScale() )
	-- statue:SetForwardVector( target:GetForwardVector() )

	-- get current animation
	print("GetSequence: ",caster:GetSequence())
	print("IsSequenceFinished: ",caster:IsSequenceFinished())
	print("SequenceDuration: ",caster:SequenceDuration(caster:GetSequence()))
	print("ActiveSequenceDuration: ",caster:ActiveSequenceDuration())
	caster:StopAnimation()
	caster:SetPoseParameter( caster:GetSequence(), 0.5 )

	-- kill and remove
	-- target:Kill( self, caster )
	-- target:AddNoDraw()
end