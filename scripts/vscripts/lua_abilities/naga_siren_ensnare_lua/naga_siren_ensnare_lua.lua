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
naga_siren_ensnare_lua = class({})
LinkLuaModifier( "modifier_naga_siren_ensnare_lua", "lua_abilities/naga_siren_ensnare_lua/modifier_naga_siren_ensnare_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Phase Start
function naga_siren_ensnare_lua:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local index = self:GetAbilityIndex()+1 or 2
	local gesture = _G["ACT_DOTA_CAST_ABILITY_" .. index ]

	-- load data
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )

	-- find all illusions
	local illusions = FindUnitsInRadius(
		caster:GetTeamNumber(),	-- int, your team number
		caster:GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		fake_radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	-- filter
	local playerID = caster:GetPlayerOwnerID()
	local model = caster:GetModelName()
	for _,illusion in pairs(illusions) do
		if illusion:GetPlayerOwnerID()==playerID and illusion:IsIllusion() and illusion:GetModelName()==model then
			-- fake gesture
			illusion:StartGesture( gesture )

			-- save for projectile
			self.illusions[illusion] = true
		end
	end

	return true -- if success
end

function naga_siren_ensnare_lua:OnAbilityPhaseInterrupted()
	-- clear fakes
	self.illusions = {}
end

--------------------------------------------------------------------------------
-- Ability Start
naga_siren_ensnare_lua.illusions = {}
function naga_siren_ensnare_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local projectile_speed = self:GetSpecialValueFor( "net_speed" )
	local fake_radius = self:GetSpecialValueFor( "fake_ensnare_distance" )

	-- create projectile
	local projectile_name = "particles/units/heroes/hero_siren/siren_net_projectile.vpcf"
	local info = {
		Target = target,
		Source = caster,
		Ability = self,	
		
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true,                           -- Optional
		ExtraData = {
			fake = 0,
		}
	}
	ProjectileManager:CreateTrackingProjectile(info)

	-- fake projectiles
	for illusion,_ in pairs(self.illusions) do
		-- throw fake projectile
		info.Source = illusion
		info.ExtraData = {
			fake = 1
		}
		ProjectileManager:CreateTrackingProjectile(info)

		-- play effects
		local sound_cast = "Hero_NagaSiren.Ensnare.Cast"
		EmitSoundOn( sound_cast, illusion )
	end

	-- clear fakes
	self.illusions = {}

	-- play effects
	local sound_cast = "Hero_NagaSiren.Ensnare.Cast"
	EmitSoundOn( sound_cast, caster )
end

--------------------------------------------------------------------------------
-- Projectile
function naga_siren_ensnare_lua:OnProjectileHit_ExtraData( target, location, data )
	if not target then return end
	if data.fake==1 then return end

	if target:IsMagicImmune() then return end

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- load data
	local duration = self:GetSpecialValueFor( "duration" )

	-- ensnare
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_naga_siren_ensnare_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- play effects
	local sound_cast = "Hero_NagaSiren.Ensnare.Target"
	EmitSoundOn( sound_cast, target )
end