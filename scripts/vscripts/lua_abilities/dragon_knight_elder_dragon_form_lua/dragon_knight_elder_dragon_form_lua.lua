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
dragon_knight_elder_dragon_form_lua = class({})
LinkLuaModifier( "modifier_dragon_knight_elder_dragon_form_lua", "lua_abilities/dragon_knight_elder_dragon_form_lua/modifier_dragon_knight_elder_dragon_form_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function dragon_knight_elder_dragon_form_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- add modifier
	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_dragon_knight_elder_dragon_form_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_DragonKnight.DragonTail.DragonFormCast"
	EmitSoundOn( sound_cast, caster )
end

-- --------------------------------------------------------------------------------
-- function dragon_knight_elder_dragon_form_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "particles/units/heroes/hero_heroname/heroname_ability.vpcf"
-- 	local sound_cast = "string"

-- 	-- Get Data

-- 	-- Create Particle
-- 	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
-- 	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
-- 	ParticleManager:SetParticleControlEnt(
-- 		effect_cast,
-- 		iControlPoint,
-- 		hTarget,
-- 		PATTACH_NAME,
-- 		"attach_name",
-- 		vOrigin, -- unknown
-- 		bool -- unknown, true
-- 	)
-- 	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
-- 	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
-- 	ParticleManager:ReleaseParticleIndex( effect_cast )

-- 	-- Create Sound
-- 	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
-- 	EmitSoundOn( sound_target, target )
-- end