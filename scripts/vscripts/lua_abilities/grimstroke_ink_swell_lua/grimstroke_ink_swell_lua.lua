grimstroke_ink_swell_lua = class({})
LinkLuaModifier( "modifier_grimstroke_ink_swell_lua", "lua_abilities/grimstroke_ink_swell_lua/modifier_grimstroke_ink_swell_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_stunned_lua", "lua_abilities/generic/modifier_generic_stunned_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function grimstroke_ink_swell_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("buff_duration")

	-- add modifier
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_grimstroke_ink_swell_lua", -- modifier name
		{
			duration = duration,
		} -- kv
	)

	-- Play effects
	self:PlayEffects()
end

--------------------------------------------------------------------------------
function grimstroke_ink_swell_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_grimstroke/grimstroke_cast_ink_swell.vpcf"
	local sound_cast = "Hero_Grimstroke.InkSwell.Cast"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetCaster() )
end