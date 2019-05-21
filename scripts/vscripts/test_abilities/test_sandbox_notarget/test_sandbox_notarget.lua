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
test_sandbox_notarget = class({})
LinkLuaModifier( "modifier_test_sandbox_notarget", "lua_abilities/test_sandbox_notarget/modifier_test_sandbox_notarget", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Custom KV
-- function test_sandbox_notarget:GetBehavior()

-- end

-- -- AOE Radius
-- function test_sandbox_notarget:GetAOERadius()
-- 	return self:GetSpecialValueFor( "radius" )
-- end

-- -- CD
-- function test_sandbox_notarget:GetCooldown( level )
-- 	if self:GetCaster():HasScepter() then
-- 		return self:GetSpecialValueFor( "cooldown_scepter" )
-- 	end

-- 	return self.BaseClass.GetCooldown( self, level )
-- end

--------------------------------------------------------------------------------
-- Ability Start
function test_sandbox_notarget:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local casterid = caster:GetPlayerOwnerID()

	-- local event = 
	-- {
	-- 	gold = 0,
	-- 	killer_id = caster:GetPlayerOwnerID(),
	-- 	killer_streak = 0,
	-- 	killer_multikill = 5,
	-- }
	-- FireGameEvent( "dota_chat_kill_streak", event )
	-- EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_dominate_01" )
	-- EmitAnnouncerSound( "announcer_killing_spree_announcer_kill_rampage_01" )

	-- for i=0,10 do
	-- 	local event = {
	-- 		-- userid = caster:GetPlayerOwnerID(),
	-- 		userid = 0,
	-- 		value = 1,
	-- 		message = i,
	-- 	}
	-- 	FireGameEvent( "dota_pause_event", event )
	-- end

	-- for i=0,10 do
	-- 	local event = {
	-- 		reason = i,
	-- 		message = "#cannot_go",
	-- 	}
	-- 	FireGameEvent( "dota_hud_error_message", event )
	-- end
	-- caster:IncrementLastHitMultikill()
	-- caster:IncrementLastHitMultikill()
	-- caster:IncrementLastHitMultikill()
	-- caster:IncrementLastHitMultikill()
	-- caster:IncrementLastHitStreak()
	-- caster:IncrementLastHits()

	local streak = 0

	-- PlayerResource:IncrementLastHitMultikill( casterid )
	-- streak = PlayerResource:GetLastHitMultikill( casterid )
	-- Say( caster, "Streak :" .. streak, false )

	-- PlayerResource:IncrementLastHitStreak( casterid )
	-- streak = PlayerResource:GetLastHitStreak( casterid )
	-- Say( caster, "Streak :" .. streak, false )

	-- PlayerResource:IncrementStreak( casterid )
	-- streak = caster:GetStreak()
	-- Say( caster, "Streak: " .. streak, false )

	-- PlayerResource:UpdateTeamSlot( casterid, caster:GetTeamNumber(), 3 )
	PlayerResource:SetCustomPlayerColor( casterid, 1, 1, 1 )

	self:PlayEffects()
end
--------------------------------------------------------------------------------
-- Projectile
function test_sandbox_notarget:OnProjectileHit( target, location )
end

--------------------------------------------------------------------------------
function test_sandbox_notarget:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 100, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Particle
	-- ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	-- ParticleManager:SetParticleControlEnt(
	-- 	effect_cast,
	-- 	iControlPoint,
	-- 	hTarget,
	-- 	PATTACH_NAME,
	-- 	"attach_name",
	-- 	vOrigin, -- unknown
	-- 	bool -- unknown, true
	-- )
	-- ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	-- SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )

	-- -- Create Sound
	-- local sound_cast = "string"
	-- EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	-- EmitSoundOn( sound_target, target )
end