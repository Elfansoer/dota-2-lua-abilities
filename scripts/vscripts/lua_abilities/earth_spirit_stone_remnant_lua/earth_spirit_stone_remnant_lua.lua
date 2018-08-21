earth_spirit_stone_remnant_lua = class({})
LinkLuaModifier( "modifier_earth_spirit_stone_remnant_lua", "lua_abilities/earth_spirit_stone_remnant_lua/modifier_earth_spirit_stone_remnant_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_generic_charges", "lua_abilities/generic/modifier_generic_charges", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
-- function earth_spirit_stone_remnant_lua:GetIntrinsicModifierName()
-- 	return "modifier_earth_spirit_stone_remnant_lua"
-- end

--------------------------------------------------------------------------------
-- Ability Start
function earth_spirit_stone_remnant_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	-- local duration = self:GetSpecialValueFor("duration")
	local duration = 7

	-- summon stone
	local stone = CreateUnitByName( "npc_dota_earth_spirit_stone", point, true, nil, nil, DOTA_TEAM_NEUTRALS )
	stone:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_earth_spirit_stone_remnant_lua", -- modifier name
		{ duration = duration } -- kv
	)
end

function earth_spirit_stone_remnant_lua:OnHeroCalculateStatBonus()
	if self:GetLevel()<1 then
		self:SetLevel(1)
		self.OnHeroCalculateStatBonus = nil
	end
end

--------------------------------------------------------------------------------
-- function earth_spirit_stone_remnant_lua:PlayEffects()
-- 	-- Get Resources
-- 	local particle_cast = "string"
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