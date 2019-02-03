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
midas_golden_touch = class({})
LinkLuaModifier( "modifier_midas_golden_touch", "custom_abilities/midas_golden_touch/modifier_midas_golden_touch", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Cast Filter
function midas_golden_touch:CastFilterResultTarget( hTarget )
	if self:GetCaster() == hTarget then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter(
		hTarget,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_TREE,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_CHECK_DISABLE_HELP,
		self:GetCaster():GetTeamNumber()
	)
	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function midas_golden_touch:GetCustomCastErrorTarget( hTarget )
	if self:GetCaster() == hTarget then
		return "#dota_hud_error_cant_cast_on_self"
	end

	return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function midas_golden_touch:OnSpellStart( kv )
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("hero_duration")
	local tree_gold = self:GetSpecialValueFor("tree_gold")

	-- if tree
	if target:GetClassname()=="ent_dota_tree" then
		GridNav:DestroyTreesAroundPoint(target:GetOrigin(), 0, true)
		caster:ModifyGold( tree_gold, false, 0 )
		self:PlayEffects1( tree_gold )
		self:PlayEffects2( target:GetOrigin() )
		return
	end

	-- cancel if linken or midas
	-- if target:TriggerSpellAbsorb( self ) or target:GetUnitName()=="npc_dota_hero_midas" then
	if target:TriggerSpellAbsorb( self ) or target:GetUnitName()=="npc_dota_hero_dragon_knight" then
		self:PlayEffects3( target )
		return
	end

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_midas_golden_touch", -- modifier name
		{ duration = duration } -- kv
	)

	-- Play effects
	local sound_cast = "Hero_Invoker.ColdSnap"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- Graphics & Animations
-- Gold Effect
function midas_golden_touch:PlayEffects1( gold )
	-- Get Resources
	local particle_cast = "particles/msg_fx/msg_goldbounty.vpcf"

	-- load data
	local digit = 0
		if gold<10 then digit = 1
	elseif gold<100 then digit = 2
	elseif gold<1000 then digit = 3
	elseif gold<10000 then digit = 4
	else digit = 5 end

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_OVERHEAD_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 0, gold, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, digit+1, 0 ) )
	ParticleManager:SetParticleControl( effect_cast, 3, Vector( 255, 255, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

-- Tree effect
function midas_golden_touch:PlayEffects2( location )
	-- Get Resources
	local particle_cast = "particles/midas_golden_touch_tree_dire.vpcf"
	local sound_cast = "General.Coins"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, location )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	EmitSoundOn( sound_cast, self:GetCaster() )
end

function midas_golden_touch:PlayEffects3( target )
	-- Get Resources
	local particle_cast = "particles/midas_golden_touch_explode.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, target:GetOrigin() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- play sound
	local sound_cast = "Hero_VengefulSpirit.MagicMissileImpact"
	EmitSoundOn( sound_cast, target )
end