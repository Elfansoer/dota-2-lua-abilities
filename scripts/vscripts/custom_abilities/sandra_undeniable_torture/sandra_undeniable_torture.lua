sandra_undeniable_torture = class({})
LinkLuaModifier( "modifier_sandra_undeniable_torture", "custom_abilities/sandra_undeniable_torture/modifier_sandra_undeniable_torture", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sandra_undeniable_torture_debuff", "custom_abilities/sandra_undeniable_torture/modifier_sandra_undeniable_torture_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sandra_undeniable_torture:GetIntrinsicModifierName()
	return "modifier_sandra_undeniable_torture"
end

--------------------------------------------------------------------------------
-- Custom KV
-- AOE Radius
function sandra_undeniable_torture:GetAOERadius()
	return self:GetSpecialValueFor( "radius" )
end

--------------------------------------------------------------------------------
-- Ability Start
function sandra_undeniable_torture:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local radius = self:GetSpecialValueFor("radius")

	-- logic
	local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),	-- int, your team number
			point,	-- point, center point
			nil,	-- handle, cacheUnit. (not known)
			radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
			DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,	-- int, flag filter
			0,	-- int, order filter
			false	-- bool, can grow cache
	)

	self.modifiers = {}
	for _,enemy in pairs(enemies) do
		-- add modifier
		local modifier = enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_sandra_undeniable_torture_debuff", -- modifier name
			{ duration = self:GetSpecialValueFor( "max_channel" ) } -- kv
		)
		table.insert( self.modifiers, modifier )
	end

	-- effects
	self:PlayEffects(point,radius)
end

--------------------------------------------------------------------------------
-- Ability Channeling
function sandra_undeniable_torture:GetChannelTime()
	return self:GetSpecialValueFor("max_channel")
end

function sandra_undeniable_torture:OnChannelFinish( bInterrupted )
	for _,modifier in pairs(self.modifiers) do
		if not modifier:IsNull() then
			modifier:Destroy()
		end
	end
end

--------------------------------------------------------------------------------
function sandra_undeniable_torture:PlayEffects( point, radius)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_explode.vpcf"
	local sound_cast = "hero_bloodseeker.bloodRite.silence"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(radius,radius,1) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
end