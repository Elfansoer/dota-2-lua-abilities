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
terrorblade_conjure_image_lua = class({})
LinkLuaModifier( "modifier_terrorblade_conjure_image_lua", "lua_abilities/terrorblade_conjure_image_lua/modifier_terrorblade_conjure_image_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function terrorblade_conjure_image_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()

	-- load data
	local duration = self:GetSpecialValueFor( "illusion_duration" )
	local outgoing = self:GetSpecialValueFor( "illusion_outgoing_damage" )
	local incoming = self:GetSpecialValueFor( "illusion_incoming_damage" )
	local distance = 72

	-- create illusion
	local illusions = CreateIllusions(
		caster, -- hOwner
		caster, -- hHeroToCopy
		{
			outgoing_damage = outgoing,
			incoming_damage = incoming,
			duration = duration,
		}, -- hModiiferKeys
		1, -- nNumIllusions
		distance, -- nPadding
		false, -- bScramblePosition
		true -- bFindClearSpace
	)
	local illusion = illusions[1]

	self:SetContextThink( DoUniqueString( "terrorblade_conjure_image_lua" ),function()
		illusion:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_terrorblade_conjure_image_lua", -- modifier name
			{ duration = duration } -- kv
		)

		-- Play effects
		local sound_cast = "Hero_Terrorblade.ConjureImage"
		EmitSoundOn( sound_cast, illusion )

	end, FrameTime()*2)
end
-- --------------------------------------------------------------------------------
-- -- Projectile
-- function terrorblade_conjure_image_lua:OnProjectileHit( target, location )
-- end

-- --------------------------------------------------------------------------------
-- function terrorblade_conjure_image_lua:PlayEffects()
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