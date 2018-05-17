shaco_jack_in_the_box = class({})
LinkLuaModifier( "modifier_shaco_jack_in_the_box", "custom_abilities/shaco_jack_in_the_box/modifier_shaco_jack_in_the_box", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_shaco_jack_in_the_box_fear", "custom_abilities/shaco_jack_in_the_box/modifier_shaco_jack_in_the_box_fear", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Ability Start
function shaco_jack_in_the_box:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- load data
	local duration = self:GetSpecialValueFor("duration")

	-- spawn the box
	local box = CreateUnitByName( 
		"npc_dota_shaco_jack_in_the_box",
		point,
		true,
		self:GetCaster(),
		self:GetCaster():GetOwner(),
		self:GetCaster():GetTeamNumber()
	)
	box:SetControllableByPlayer( self:GetCaster():GetPlayerID(), false )
	box:SetOwner( self:GetCaster() )

	-- add modifier
	box:AddNewModifier(
		caster, -- player source
		self, -- ability source
		"modifier_shaco_jack_in_the_box", -- modifier name
		{ duration = duration } -- kv
	)
end

--------------------------------------------------------------------------------
function shaco_jack_in_the_box:PlayEffects()
	-- Get Resources
	local particle_cast = "string"
	local sound_cast = "string"

	-- Get Data

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_NAME, hOwner )
	ParticleManager:SetParticleControl( effect_cast, iControlPoint, vControlVector )
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		iControlPoint,
		hTarget,
		PATTACH_NAME,
		"attach_name",
		vOrigin, -- unknown
		bool -- unknown, true
	)
	ParticleManager:SetParticleControlForward( effect_cast, iControlPoint, vForward )
	SetParticleControlOrientation( effect_cast, iControlPoint, vForward, vRight, vUp )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	-- Create Sound
	EmitSoundOnLocationWithCaster( vTargetPosition, sound_location, self:GetCaster() )
	EmitSoundOn( sound_target, target )
end