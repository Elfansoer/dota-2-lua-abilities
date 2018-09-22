axe_battle_hunger_lua = class({})
LinkLuaModifier( "modifier_axe_battle_hunger_lua", "lua_abilities/axe_battle_hunger_lua/modifier_axe_battle_hunger_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_battle_hunger_lua_debuff", "lua_abilities/axe_battle_hunger_lua/modifier_axe_battle_hunger_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function axe_battle_hunger_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- cancel if linken
	if target:TriggerSpellAbsorb( self ) then return end

	-- add modifier
	target:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_axe_battle_hunger_lua_debuff", -- modifier name
		{ duration = duration } -- kv
	)

	caster:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_axe_battle_hunger_lua", -- modifier name
		{ duration = duration } -- kv
	)

	-- effects
	local sound_cast = "Hero_Axe.Battle_Hunger"
	EmitSoundOn( sound_cast, target )
end

--------------------------------------------------------------------------------
-- function axe_battle_hunger_lua:PlayEffects()
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
-- end