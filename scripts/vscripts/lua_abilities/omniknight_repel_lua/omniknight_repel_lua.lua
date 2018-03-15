omniknight_repel_lua = class({})
LinkLuaModifier( "modifier_omniknight_repel_lua", "lua_abilities/omniknight_repel_lua/modifier_omniknight_repel_lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function omniknight_repel_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local buffDuration = self:GetSpecialValueFor("duration")

	-- Add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_omniknight_repel_lua", -- modifier name
		{ duration = buffDuration } -- kv
	)

	-- Play Effects
	self:PlayEffects()
end

function omniknight_repel_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex( effect_cast )
end